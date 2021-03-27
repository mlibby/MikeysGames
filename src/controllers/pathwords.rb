module MikeysGames
  class App < Sinatra::Base
    get "/pathwords/serve" do
      @game = MikeysGames::Pathwords.instance
      erb_layout :"pathwords/serve"
    end

    get "/pathwords/play" do
      @game = MikeysGames::Pathwords.instance
      erb_layout :"pathwords/play"
    end

    get "/pathwords/server_pulse" do
      @game = MikeysGames::Pathwords.instance
      json @game.server_data
    end

    get "/pathwords/player_pulse" do
      @game = MikeysGames::Pathwords.instance
      json @game.player_data
    end

    get "/pathwords/player_join" do
      @game = MikeysGames::Pathwords.instance
      @game.players << "player"
      json @game.player_data
    end
  end
end
