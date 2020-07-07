

class API
    attr_accessor :url

    def initialize(url)
        @url = url
    end

    def get_quotes
        base_url = HTTParty.get(self.url)

        base_url["quotes"].map do |quote|        
            Quote.new(quote["quoteText"], quote["quoteAuthor"])
        end

    end




end


