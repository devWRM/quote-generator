

class API
    attr_accessor :url

    def initialize(url)
        @url = url
    end

    def get_quotes
        base_url = HTTParty.get(self.url)
binding.pry
        

    end




end


