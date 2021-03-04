require "haml"
require "sinatra/base"
require "sinatra/flash"
require_relative "repo/mikeysgames_repo"

module MikeysGames
  class App < Sinatra::Base
    enable :sessions
    register Sinatra::Flash
    # valid flash keys for MikeysGames: :info, :success, :danger

    db_connections = {
      "DEV" => "sqlite://mikeysgames.sqlite",
      "TEST" => "sqlite:/",
      "PROD" => "sqlite://mikeysgames.sqlite",
      "DEMO" => ENV["DATABASE_URL"],
      "DUMP" => "sqlite://#{ARGV[0]}"
    }

    @@repo = MikeysGames::Repo.new db_connections[ENV["APP_ENV"] || "DEV"]

    set :public_folder, "#{__dir__}/www"
    set :strict_paths, false
    set :method_override, true

    @@token = MikeysGames::Repo.timestamp
    def self.token
      @@token
    end

    @@require_token = ["DELETE", "POST", "PUT"]
    before do
      if @@require_token.include?(request.env["REQUEST_METHOD"])
        if ENV["APP_ENV"] == "DEMO"
          halt 405, "Making changes to the Demo site is not allowed. <a href='javascript:history.back()'>Go Back</a>"
        end
        if !(params.has_key? "_token")
          halt 403, "CSRF Token Required"
        end
      end
    end

    require_relative "./lib/mikeysgames_lib"
    require_relative "./controllers/mikeysgames_controllers"

    def haml_layout(view)
      haml view, layout: :layout
    end

    run! if app_file == $0
  end
end
