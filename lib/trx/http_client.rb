module Trx
  class HttpClient
    attr_reader :host, :timeout, :trongrig_token, :headers, :raise_error

    MAINNET_HOST = "https://api.trongrid.io"
    SHASTA_HOST = "https://api.shasta.trongrid.io"
    NILE_HOST = "https://nile.trongrid.io"

    def initialize(host = nil, timeout: 30, trongrig_token: nil, headers: {}, raise_error: true)
      @host = host
      @timeout = timeout
      @trongrig_token = trongrig_token
      @headers = headers
      @raise_error = raise_error
    end

    def perform_command(command, method: :post, **params)
      connection.public_send(method, command, **params).body
    end

    private

    def connection
      @_connection ||= Faraday.new(host) do |builder|
        builder.use Faraday::Response::RaiseError if raise_error
        builder.request :url_encoded
        builder.response :json
        builder.adapter Faraday.default_adapter
        builder.headers['TRON-PRO-API-KEY'] = trongrig_token unless trongrig_token.nil?
      end
    end
  end
end
