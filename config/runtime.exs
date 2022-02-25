# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
import Config

IO.puts("Reading releases file")

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """
    
static_url =
  System.get_env("EDGE_URL")
  |> URI.parse()
  |> Map.from_struct()
    
config :tilex, Tilex.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true
  
config :tilex, TilexWeb.Endpoint,
  http: [port: {:system, "PORT"}, compress: true],
  url: [host: System.get_env("HOST"), port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: secret_key_base,
  static_url: static_url,
  server: true
  
config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET")

config :tilex, :edge_url, System.get_env("EDGE_URL")
config :tilex, :organization_name, System.get_env("ORGANIZATION_NAME")
config :tilex, :canonical_domain, System.get_env("CANONICAL_DOMAIN")
config :tilex, :hosted_domain, System.get_env("HOSTED_DOMAIN")
config :tilex, :guest_author_allowlist, System.get_env("GUEST_AUTHOR_ALLOWLIST")
config :tilex, :default_twitter_handle, System.get_env("DEFAULT_TWITTER_HANDLE")
config :tilex, :date_display_tz, System.get_env("DATE_DISPLAY_TZ")
config :tilex, :slack_endpoint, System.get_env("SLACK_POST_ENDPOINT")
 
# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
