defmodule EntitySports.Schema do
  @moduledoc """
  Shared boilerplate for EntitySports models.

      defmodule EntitySports.Model.Foo do
        use EntitySports.Schema

        embedded_schema do
          field(:id, :integer)
          embeds_one(:team, EntitySports.Model.TeamDetail)
        end
      end

  Provides:

    * `changeset/1` and `changeset/2` casting every field and embed declared
      in the schema. Params are normalised with `EntitySports.Helper.sanitize/2`
      first, so `[]`/`""` placeholders for absent objects do not fail the cast.
    * `render/1` - builds the struct from a decoded API response, keeping the
      raw payload under `raw_response` when the schema declares that field.
    * `render_many/1` - renders a paginated `items` list.
    * `prepare/1` - overridable hook applied to params before casting.
  """

  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      alias EntitySports.Helper
      alias EntitySports.Model
      alias EntitySports.Type.Raw
      alias EntitySports.Type.Number

      @type t :: %__MODULE__{}

      @derive Jason.Encoder
      @primary_key false
      @before_compile EntitySports.Schema

      @doc "Hook applied to params before casting. Override when needed."
      def prepare(params), do: params

      defoverridable prepare: 1
    end
  end

  defmacro __before_compile__(env) do
    embeds = Module.get_attribute(env.module, :ecto_embeds) || []
    fields = Module.get_attribute(env.module, :ecto_fields) || []

    embed_names = Enum.map(embeds, fn {name, _} -> name end)
    one_keys = for {name, %{cardinality: :one}} <- embeds, do: name
    many_keys = for {name, %{cardinality: :many}} <- embeds, do: name
    map_keys = for {name, :map} <- fields, do: name
    cast_fields = for {name, _type} <- fields, name not in embed_names, do: name
    raw? = :raw_response in cast_fields

    quote do
      @cast_fields unquote(cast_fields)
      @sanitize_one unquote(one_keys ++ map_keys)
      @sanitize_many unquote(many_keys)
      @embed_names unquote(embed_names)

      def changeset(params), do: changeset(%__MODULE__{}, params)

      def changeset(struct, params) do
        params =
          params
          |> prepare()
          |> EntitySports.Helper.sanitize(one: @sanitize_one, many: @sanitize_many)

        changeset = cast(struct, params, @cast_fields)
        Enum.reduce(@embed_names, changeset, fn name, cs -> cast_embed(cs, name) end)
      end

      def render(response) do
        params =
          if unquote(raw?),
            do: EntitySports.Helper.append_raw_response(response, response),
            else: response

        case params |> changeset() |> apply_action(nil) do
          {:ok, model} -> {:ok, model}
          {:error, changeset} -> {:error, changeset, response}
        end
      end

      def render_many(response),
        do: EntitySports.Helper.render_page(response, &__MODULE__.render/1)

      defoverridable changeset: 2, render: 1, render_many: 1
    end
  end
end
