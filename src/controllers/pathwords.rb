class MikeysGames < Sinatra::Base
  get "/pathwords/serve" do
    @game = Pathwords.instance
    erb_layout :"pathwords/serve"
  end

  get "/pathwords/play" do
    @game = Pathwords.instance
    @player = @game.find_player(cookies[:player_id])
    erb_layout :"pathwords/play"
  end

  get "/pathwords/server_pulse" do
    @game = Pathwords.instance
    json @game.server_data
  end

  get "/pathwords/player_pulse" do
    @game = Pathwords.instance
    json @game.player_data
  end

  post "/pathwords/player_join" do
    cookies[:player_name] = request.params["player_name"]
    @game = Pathwords.instance
    @game.add_player Pathwords::Player.new(cookies[:player_id], cookies[:player_name])
    redirect "/pathwords/play"
  end
end
