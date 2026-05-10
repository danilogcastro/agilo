module Mapbox
  class Geocoder
    def self.call(...)
      new(...).execute
    end

    attr_reader :address, :language, :country, :limit

    PATH = "/search/geocode/v6/forward"

    def initialize(address:, language: "en", country: nil, limit: 1)
      @address = address
      @language = language
      @country = country
      @limit = limit
    end

    def execute
      {
        latitude: geocode_data.dig(:features, 0, :properties, :coordinates, :latitude),
        longitude: geocode_data.dig(:features, 0, :properties, :coordinates, :longitude)
      }
    end

    private

    def geocoder
      @geocoder ||= Mapbox::Request.new(path: PATH, params:)
    end

    def params
      @params ||= {
        q: address,
        language: language,
        limit: limit,
        country: country
      }.compact
    end

    def geocode_data
      @geocode_data ||= geocoder.execute
    end
  end
end
