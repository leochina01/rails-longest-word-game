class GamesController < ApplicationController
require "json"
require "open-uri"
  def new
    array_letters = ("a".."z").to_a
    @letters = array_letters.sample(9)
    # array_numbers = [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
    # @numbers = array_numbers.sample
  end

  def score
    # 1 - Read the form that was sent
    letters = params[:letters].split(" ") # -> Get all Letters in an array- individually split, no spaces
    # raise
    params[:word]
    word = params[:word]
    word_letters = params[:word].split("") # -> Get all letters in word
    # 2 - check if the word fits the grid
    grid_fit = true
    word_letters.each do |letter|
      if letters.include?(letter)
        letters.delete_at(letters.index(letter))
      else
        grid_fit = false
      end
    end
    # raise
    # 3 - check API => if it is an English word
    word_exist = false
    url = "https://dictionary.lewagon.com/#{word}"
    response = URI.parse(url).read
    data = JSON.parse(response)
    if data["found"] == true
      word_exist = true
    end
    # 4 - Decide decide which of the 3 messages to show
    # 5 - Display it in the view, with link back
    # if built a word that is not in the array of letters proposed ->
    if grid_fit == false
      @message = "Sorry bu #{word} can't be bult out of #{params[:letters]}"
    # elsif word is not a valid english word ->
    elsif word_exist == false
      @message = "Sorry bu #{word} does not seems to be a valid English word"
    else
      @message = "Congratulations! #{word} is a valid English word!"
    end
  end
end
