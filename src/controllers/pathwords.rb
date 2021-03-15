module MikeysGames
  class App < Sinatra::Base
    get "/pathwords" do
      @game = MikeysGames::Pathwords.instance
      erb_layout :"pathwords/index"
    end

    get "/pathwords/play" do
      @game = MikeysGames::Pathwords.instance
      erb_layout :"pathwords/play"
    end
  end
end
