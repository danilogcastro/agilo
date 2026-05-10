module Mapbox
  class Request
    BASE_URL='api.mapbox.com'

    attr_reader :path, :params

    def initialize(path:, params:)
      @path = path
      @params = params
    end

    def execute
      JSON.parse(response.body, symbolize_names: true)
    end

    def response
      Faraday.get(url, query)
    end

    def url
      uri = URI::HTTPS.build(host: BASE_URL)
      uri.path = path
      uri.to_s
    end

    def query
      @query ||= params.merge(
        {
          access_token: ENV.fetch('MAPBOX_ACCESS_TOKEN')
        }
      )
    end
  end
end
