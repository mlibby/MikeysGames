class MikeysGames < Sinatra::Base
  get "/pathwords/serve" do
    addr = Socket.ip_address_list.detect { |addr| addr.ipv4_private? }
    port = request.env["SERVER_PORT"]
    @server = "#{addr.ip_address}:#{port}"
    @qr_code = qr_code("http://#{@server}/")
    @title = "Pathwords"
    @game = Pathwords.instance
    erb_layout :"pathwords/serve"
  end

  get "/pathwords/play" do
    @title = "Pathwords"
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
    cookies[:player_name] = request.params["player-name"]
    @game = Pathwords.instance
    @game.add_player Pathwords::Player.new(cookies[:player_id], cookies[:player_name])
    redirect "/pathwords/play"
  end

  post "/pathwords/player_expect" do
    @game = Pathwords.instance
    @game.set_players_expected request.params["players-expected"]
    redirect "/pathwords/play"
  end

  post "/pathwords/player_next" do
    @game = Pathwords.instance
    @game.player_next(cookies[:player_id])
    redirect "/pathwords/play"
  end
end
