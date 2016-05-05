# genius/api.rb

class API

  ARTISTS = [
    'Des\'ree',
    'Jonah, The Whale',
    'Beyoncé',
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
      elsif match_without_punctuation(query, artist)
        artist
      elsif match_with_special_characters_replaced(query, artist)
        artist
      elsif fuzzy_match(query, artist)
        artist
      end
    end
    return results

  end

  # unpunctuated_artist = artist.gsub(/\p{^Alnum}/, '')
  # artist if query.match(unpunctuated_artist)

  def self.match_without_punctuation(query, artist)
    query.match(artist.gsub(/\p{^Alnum}/, ''))
  end

  def self.match_with_special_characters_replaced(query, artist)
    convert_special_characters(query).match(convert_special_characters(artist))
  end

  def self.convert_special_characters(string)
    fallback = {
      'Š' => 'S', 'š' => 's', 'Ð' => 'Dj',
      'Ž' => 'Z', 'ž' => 'z', 'À' => 'A', 'Á' => 'A',
      'Â' => 'A', 'Ã' => 'A', 'Ä' => 'A','Å' => 'A',
      'Æ' => 'A', 'Ç' => 'C', 'È' => 'E', 'É' => 'E',
      'Ê' => 'E', 'Ë' => 'E', 'Ì' => 'I', 'Í' => 'I',
      'Î' => 'I','Ï' => 'I', 'Ñ' => 'N', 'Ò' => 'O',
      'Ó' => 'O', 'Ô' => 'O', 'Õ' => 'O', 'Ö' => 'O',
      'Ø' => 'O', 'Ù' => 'U', 'Ú' => 'U','Û' => 'U',
      'Ü' => 'U', 'Ý' => 'Y', 'Þ' => 'B', 'ß' => 'Ss',
      'à' => 'a', 'á' => 'a', 'â' => 'a', 'ã' => 'a',
      'ä' => 'a','å' => 'a', 'æ' => 'a', 'ç' => 'c',
      'è' => 'e', 'é' => 'e', 'ê' => 'e', 'ë' => 'e',
      'ì' => 'i', 'í' => 'i', 'î' => 'i','ï' => 'i',
      'ð' => 'o', 'ñ' => 'n', 'ò' => 'o', 'ó' => 'o',
      'ô' => 'o', 'õ' => 'o', 'ö' => 'o', 'ø' => 'o',
      'ù' => 'u','ú' => 'u', 'û' => 'u', 'ý' => 'y',
      'ý' => 'y', 'þ' => 'b', 'ÿ' => 'y', 'ƒ' => 'f'
    }

    string.encode('us-ascii', :fallback => fallback)
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
