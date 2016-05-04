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

    # before refactor: return "Looks like you didn't enter a valid query - try again." if query == ('' || nil)
    return "Looks like you didn't enter a valid query - try again." if (query == '' || query ==nil)

    # num_letters_to_match = (query.length * 0.6).to_i # Match a little more than half of the letters
    # regex = /[#{query}]{#{num_letters_to_match},}/
    regex = format_to_regex(query)

    results = ARTISTS.find_all do |artist|
      if artist.include?(query) # first check exact match
        artist
      elsif artist.match(regex) # then check fuzzy match
        artist
      end
    end

    return results

  end

  def self.format_to_regex(string)
    num_letters_to_match = (string.length * 0.7).to_i # Match a little more than half of the letters
    regex = /[#{string}]{#{num_letters_to_match},}/
  end

end
