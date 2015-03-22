require 'cgi'

module PadelScrap
  class GolfCanal < SportsCenter

    BASE_ENDPOINT = 'https://golfcanal.padelclick.com'
    LOGIN_PATH    = BASE_ENDPOINT + '/customer/login'
    BOOKING_PATH  = BASE_ENDPOINT + '/booking/index'

    SUCCESS_TEXT = 'Enhorabuena'

    def initialize(debug: false)
      @debug = debug

      initialize_connection
    end

    def check_availability(date, hour, duration)
      params = "date=#{CGI.escape(date)}&type=56&hour=#{hour}%3A00&duration=#{duration}"
      response_page = post(BOOKING_PATH, params)

      available = response_page.body.include?(SUCCESS_TEXT)
      alternatives = available ? [] : alternatives(response_page)

      {
        available: available,
        alternatives: alternatives
      }
    end

    private
      def alternatives(response_page)
        response_page.parser.css('span.alternative').map do |alternative|
          parse_alternative_text(alternative.text)
        end.compact
      end

      def parse_alternative_text(alternative)
        matches = /.*(\d\d:\d\d).*(\d\d:\d\d).*/.match(alternative)
        if matches
          {
            start_hour: matches.captures[0],
            end_hour: matches.captures[1]
          }
        end
      end
  end
end
