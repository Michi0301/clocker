class Static::HostingController < Static::BaseController
  def ping
    render plain: "pong"
  end
end
