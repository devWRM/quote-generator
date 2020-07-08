

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
        puts ""
        puts "*****"
        puts ""
        puts "GREETINGS from the Words of Wisdom quote generator! We have quotes to inspire and guide you through this challenging day."
        puts "To get started on the path to peace and perspicacity, please pick a number from the menu and enter it below."
        puts ""
        puts "*****"
        puts ""
    end

    def menu
        puts "Enter 1 to see a daily quote"
        puts "Enter 2 to see all quotes and authors"
        puts "Enter 3 to see all quotes ordered by authors"
        puts "Enter 4 to see a list of all authors"
        puts "Enter 5 to see all quotes"
        puts "Enter 6 to see all quotes by one author"
        puts "Enter 0 to end this session of Words of Wisdom"    

        get_input

        if input == 0
            return adios
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
            all_quotes_for_one_author
            menu
        end
    end

    def get_input

        user_input = gets.chomp

        if ["0", "1", "2", "3", "4", "5", "6"].include?(user_input)
            self.input = user_input.to_i
        else
            puts ""
            puts "PLEAS ENTER A VALID NUMBER 0 - 6"
            puts ""
            return menu
        end
    end

    def daily_quote
        daily = Quote.all.sample

        if daily.author == ""
            puts ""
            puts daily.text
            puts "          -by Unknown"
            puts ""
        else
            puts ""
            puts daily.text
            puts "          -by #{daily.author}"
            puts ""
        end
    end

    def all_quotes_and_authors
        Quote.all.each do |quote|
            if quote.author == ""
                puts "#{quote.text} => by UNKNOWN"
            else
                puts "#{quote.text} => by #{quote.author.upcase}"
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

    def all_authors
        authors = Quote.all.map do |quote|
            quote.author
        end
        authors.uniq.sort
    end

    def authors
        authors = all_authors

        puts "KNOWN AUTHORS TOTAL: #{authors.count}"
        authors.each do |author|
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

    def all_quotes_for_one_author
        authors
        puts "COPY AND PASTE AN AUTHOR'S NAME OR ENTER A NAME BELOW"
        user_input = gets.chomp

        author_quotes = Quote.all.select do |quote|
            quote.author.upcase == user_input.upcase
        end

        if author_quotes == []
            puts "There are currently no quotes for #{user_input}"
        else                    
                puts "ALL QUOTES BY #{user_input.upcase}"
                author_quotes.each do |quote|
                    puts quote.text
                end
        end       
    end

    def adios
        puts "Parting is such sweet sorrow... -Juliet (Shakespear's Romeo and Juliet)"
    end


end

