require "sinatra/base"
require "sinatra/flash"
require "sinatra/json"
require_relative "lib/mikeysgames_lib"
require_relative "repo/mikeysgames_repo"
require_relative "controllers/mikeysgames_controllers"

module MikeysGames
  class App < Sinatra::Base
    enable :sessions
    register Sinatra::Flash
    # valid flash keys for MikeysGames: :info, :success, :danger

    db_connections = {
      "DEV" => "sqlite://mikeysgames.sqlite",
      "TEST" => "sqlite:/",
      "PROD" => "sqlite://mikeysgames.sqlite",
      "DUMP" => "sqlite://#{ARGV[0]}",
    }

    @@repo = MikeysGames::Repo.new db_connections[ENV["APP_ENV"] || "DEV"]

    set :public_folder, "#{__dir__}/www"
    set :strict_paths, false
    set :method_override, true
    set :views, File.join(File.dirname(__FILE__), "views")

    def erb_layout(view)
      erb view, layout: :layout
    end
  end
end
