require 'mechanize'

module PadelScrap
  class SportsCenter

    WEB_USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36'
    attr_accessor :headers

    def initialize(user, password, debug: false)
    end

    private

    def get(url, params = {})
      @http.get(url, params).body
    end

    def post(url, fields)
      @http.post(url, fields, @headers).body
    end

    def put(url, fields)
      @http.put(url, fields, @headers).body
    end

    # Sets temporary HTTP headers, execute a code block
    # and resets the headers
    def with_headers(tmp_headers)
      current_headers = @headers
      set_headers(tmp_headers)
      yield
    ensure
      set_headers(current_headers)
    end

    def set_headers(headers)
      @headers.merge! headers
      @http.request_headers = @headers
    end

    def initialize_cookie(url)
      @http.get(url).body
    end

    def initialize_connection
      @http = Mechanize.new do |mechanize|
        mechanize.user_agent = WEB_USER_AGENT
        mechanize.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        mechanize.log = Logger.new(STDOUT) if @debug
        mechanize.set_proxy('localhost', 8888)
      end

      @headers = {}
    end
  end
end
