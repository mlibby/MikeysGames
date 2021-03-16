require "socket"

CurrentGame = nil

module MikeysGames
  class App < Sinatra::Base
    addr = Socket.ip_address_list.detect { |addr| addr.ipv4_private? }
    server = "#{addr.ip_address}:#{settings.port}"

    get "/" do
      if CurrentGame.nil?
        erb_layout :"home/play"
      else
        erb_layout :"pathwords/play"
      end
    end

    get "/serve" do
      addr = Socket.ip_address_list.detect { |addr| addr.ipv4_private? }
      @server = "#{addr.ip_address}:#{settings.port}"
      if CurrentGame.nil?
        erb_layout :"home/serve"
      else
        erb_layout :"pathwords/serve"
      end
    end
  end
end
