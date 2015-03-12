require 'cgi'

module PadelScrap
  class GolfCanal < SportsCenter

    BASE_ENDPOINT = 'https://golfcanal.padelclick.com'
    LOGIN_PATH    = BASE_ENDPOINT + '/customer/login'
    BOOKING_PATH  = BASE_ENDPOINT + '/booking/index'

    def initialize(user, password, date, hour, duration, debug: false)
      @email    = user
      @password = password.to_s
      @date     = date
      @hour     = hour
      @duration = duration
      @debug    = debug

      initialize_connection

      login
      booking(date, hour, duration)
    end

    def login
      set_headers(
        'Accept'          => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
        'Accept-Encoding' => 'gzip, deflate',
        'Content-Type'    => 'application/x-www-form-urlencoded'
      )
      params = "Email=#{CGI.escape(@email)}&Password=#{@password}&safari="
    end

    def booking
      params = "date=#{CGI.escape(@date)}&type=56&hour=#{CGI.escape(@hour)}&duration=#{CGI.escape(@duration)}"
      result = post(BOOKING_PATH, params)
      if result.include?('Enhorabuena')
        puts 'Tienes pista!'
      else
        puts 'No tienes pista!'
      end
    end
  end
end
