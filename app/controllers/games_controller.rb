require "open-uri"

class GamesController < ApplicationController
  VOWELS = %w(A E I O U Y)

  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.each_char.all? { |letter| word.count(letter) <= letters.count(letter)}
  end

  def english_word?(word)
    # look up word in dictionary
    json = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{word.downcase}").read)

    # response if found
    json["found"]
  end

end
