

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
            print_all_quotes_and_authors
            menu
        elsif input == 3

        elsif input == 4

        elsif input == 5

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

    def print_all_quotes_and_authors
        Quote.all.each do |quote|
            if quote.author == ""
                puts "#{quote.text} => by Unknown"
            else
                puts "#{quote.text} => by #{quote.author}"
            end
        end
        nil
    end













end

