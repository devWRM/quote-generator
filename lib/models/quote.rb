

class Quote
    attr_accessor :text, :author
    @@all = []

    def initialize(text, author)
        @text = text
        @author = author

        @@all << self
    end

    def self.all
        @@all
    end

    



end


