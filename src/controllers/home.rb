require "rqrcode"

CurrentGame = nil

module MikeysGames
  class App < Sinatra::Base
    def qr_code(url)
      qrcode = RQRCode::QRCode.new(url)
      qrcode.as_svg(
        offset: 0,
        color: "000",
        shape_rendering: "crispEdges",
        module_size: 6,
        standalone: true,
      )
    end

    get "/" do
      if CurrentGame.nil?
        erb_layout :"home/play"
      else
        erb_layout :"pathwords/play"
      end
    end

    get "/serve" do
      addr = Socket.ip_address_list.detect { |addr| addr.ipv4_private? }
      port = request.env["SERVER_PORT"]
      @server = "#{addr.ip_address}:#{port}"
      @qr_code = qr_code("http://#{@server}/")
      if CurrentGame.nil?
        erb_layout :"home/serve"
      else
        erb_layout :"pathwords/serve"
      end
    end
  end
end
