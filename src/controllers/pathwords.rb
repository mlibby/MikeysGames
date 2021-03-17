module MikeysGames
  class App < Sinatra::Base
    @@pulse_count = 0

    get "/pathwords/serve" do
      @game = MikeysGames::Pathwords.instance
      erb_layout :"pathwords/serve"
    end

    get "/pathwords/play" do
      @game = MikeysGames::Pathwords.instance
      erb_layout :"pathwords/play"
    end

    get "/pathwords/server_pulse" do
      @@pulse_count += 1
      json :player_count => @@pulse_count
    end
  end
end
