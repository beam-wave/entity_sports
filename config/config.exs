import Config

config :entity_sports,
  http_client_opts: [],
  client_module: EntitySports.HTTPClient,
  base_url: "https://rest.entitysport.com",
  url_prefix: "/sandbox/cricket",
  exchange_url_prefix: "/exchange",
  token: "c16eaec3abd49e3477yy567836a95ad43",
  exchange_token: "c16eaec3abd49e3477yy567836a95ad43",
  exchange_client_module: EntitySports.Exchange.HTTPClient

import_config "#{config_env()}.exs"
