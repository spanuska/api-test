# genius/api.rb

class API
  require 'pry'

  ARTISTS = [
    'Rihanna',
    'The Weeknd',
    'Drake',
    'The Game',
    'Lana Del Rey',
    'Kanye West',
    'Eminem',
    'Adele',
    'Fetty Wap',
    'Kendrick Lamar'
  ]

  def self.search(query)

    return "Looks like you didn't enter a valid query - try again." if (query == '' || query ==nil)
    
    # TODO: formulate regex for fuzzy searching
    # /[Rihanna]{3,}/ will be a match if at least 3 letters are matched. Need to find a way to include a ruby variable in the regex
    # query = regex

    ARTISTS.find_all do |artist|
      artist if artist.include?(query)
    end
  end
  
end


