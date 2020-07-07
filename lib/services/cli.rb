

class CLI
    attr_accessor :url, :input

    def initialize(url)
# bindin.pry
        @url = url
    end

    def start


        greeting

        quotables = API.new(self.url)
        quotables.get_quotes

        menu

    end

    def greeting
        puts "Welcome to the Words of Wisdom Quote Generator."
    end

    def menu
        puts "Enter 1 to get a daily quote"
        puts "Enter 2 to get all quotes and authors"
        puts "Enter 3 to get all quotes ordered by authors"
        puts "Enter 4 to get a list of all authors"
        puts "Enter 5 to get all quotes"
        puts "Enter 6 to get all quotes by one author"
        puts "Enter 0 to end this Words of Wisdom session"    

        get_input

        if input == 0
            puts "Parting is such sweet sorrow... -Juliet (Shakespear's Romeo and Juliet)"
        elsif input == 1
            daily_quote           
            menu
        elsif input == 2
            all_quotes_and_authors
            menu
        elsif input == 3
            author_ordered_quotes
            menu
        elsif input == 4
            authors
            menu
        elsif input == 5
            quotes
            menu
        elsif input == 6

        end
    end

    def get_input

        user_input = gets.chomp

        if ["0", "1", "2", "3", "4", "5", "6"].include?(user_input)
            self.input = user_input.to_i
        else
            puts "Please enter a valid number 0-6"
            return menu
        end
    end

    def daily_quote
        daily = Quote.all.sample

        if daily.author == ""
            puts "#{daily.text} -by Unknown"
        else
            puts "#{daily.text} -by #{daily.author}"
        end
    end

    def all_quotes_and_authors
        Quote.all.each do |quote|
            if quote.author == ""
                puts "#{quote.text} => by Unknown"
            else
                puts "#{quote.text} => by #{quote.author}"
            end
        end
        nil
    end

    def all_quotes_ordered_by_author
        list = Quote.all.sort do |a, b|
            a.author <=> b.author
        end
        list
    end

    def author_ordered_quotes
        current_author = nil
        all_quotes_ordered_by_author.each do |quote|
           
            if current_author != quote.author
                current_author = quote.author
                    # Handles unkown for ""
                    if quote.author == ""                  
                        puts "ALL QUOTES BY UNKOWN"
                        puts "  #{quote.text}"
                    else
                        puts "ALL QUOTES BY #{quote.author.upcase}"
                        puts "  #{quote.text}"
                    end
            else
                puts "  #{quote.text}"
            end

        end
    end

    def authors
        authors = Quote.all.map do |quote|
            quote.author
        end
        uniq_authors = authors.uniq.sort

        puts "KNOWN AUTHORS TOTAL: #{uniq_authors.count}"
        uniq_authors.each do |author|
            puts author
        end
    end

    def quotes
        quotes = Quote.all.map do |quote|
            quote.text
        end
        uniq_quotes = quotes.uniq

        puts "ALL QUOTES TOTAL: #{uniq_quotes.count}"
        uniq_quotes.each do |quote_text|
            puts quote_text
        end
    end









        # def uniq_quotes
        # end


end

