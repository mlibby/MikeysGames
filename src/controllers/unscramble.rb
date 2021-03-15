module MikeysGames
  class App < Sinatra::Base
    get "/unscramble" do
      @board = MikeysGames::Unscramble.new
      erb_layout :"unscramble/index"
    end
  end
end
