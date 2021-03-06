# genius/spec/api_spec.rb

require_relative '../api'
require 'pry'

# TEST CASES

# Case1: Queries that directly match an artist in the API
# Test: Given the query "Adele", the search method should return the array: ["Adele"]

# Case2: Queries that do not match an artist in the API
# Test: Given the query "Alkaline Trio", the search method should return an empty array

# Case3: Queries that are misspelled - fuzzy matching
# Test: Given the query "Adel", the search method should return the array: ["Adele"]

# Case4: Queries that are empty
# Test: Given an empty query, the search method should return a prompt for a valid query

RSpec.describe API do
  describe '#search' do

    it 'returns an array with tha name of the artist matching the query' do
      
      expect(API.search("Adele")).to eq(["Adele"])
      expect(API.search("Des'ree")).to eq(["Des'ree"])
      expect(API.search("Jonah, The Whale")).to eq(["Jonah, The Whale"])
      expect(API.search("Beyoncé")).to eq(["Beyoncé"])
      # expect(API.search("Adele Eminem")). to eq(["Adele", "Eminem"])
    end

    it 'returns an empty array when the query does not match any of the artists' do
      
      expect(API.search("Alkaline Trio")).to eq([])
    end

    it 'handles spelling errors and returns an array with tha name of the artist that fuzzy-matches the query' do
      
      expect(API.search("Riana")).to eq(["Rihanna"])
      expect(API.search("Desree")).to eq(["Des'ree"])
      expect(API.search("Jonah The Whale")).to eq(["Jonah, The Whale"])
      expect(API.search("Beyonce")).to eq(["Beyoncé"])
    end

    it 'returns a prompt for a valid query when given an empty query' do
      
      expect(API.search(nil)).to eq("Looks like you didn't enter a valid query - try again.")
    end    

  end
end