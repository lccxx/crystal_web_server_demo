require "http"
require "json"
require "objectid-crystal"

module CrystalWebServerDemo
  VERSION = "0.1.0"

  server = HTTP::Server.new { |ctx|
    Log.d ctx.request
    ctx.response.content_type = "text/json"
    ctx.response.print({ message: "Hello World", data: { id: ObjectId.new } }.to_json)
  }

  stop = -> {
    server.close
    Process.exit 0
  }

  Signal::INT.trap { puts "stop server with INT"; stop.call }
  Signal::TERM.trap { puts "stop server with TERN"; stop.call }

  server.listen 3980
end

module Log
  def self.d(obj)
    p obj
  end
end
