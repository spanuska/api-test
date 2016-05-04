# genius/api.rb

class API

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

    results = ARTISTS.find_all do |artist|
      if artist.include?(query) # first check exact match
        artist
      elsif fuzzy_match(query, artist) # then check fuzzy match
        artist
      end
    end

    return results

  end

  def self.fuzzy_match(query, artist)
    regex = format_to_regex(query)
    # match exists only if 
      # the artist name matches the regex patterns determined by the query string &&
      # the reverse - the query string matches the patterns of the artist name
    artist.match(regex) && query.match(format_to_regex(artist))
  end

  def self.format_to_regex(string)
    num_letters_to_match = (string.length * 0.7).to_i # Match a little more than half of the letters
    regex = /[#{string}]{#{num_letters_to_match},}/
  end

end
