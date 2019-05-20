require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0...6).map { ('a'..'z').to_a[rand(26)].upcase }
  end

  def score
    @answer = params[:question].upcase
    @letters = params[:letters].gsub(/\s+/, '')
    if check_letters(@answer, @letters)
      if check_dictionnary(user_answer)
        @game_anser = 'You win!'
      else
        @game_anser = 'Not in the dictionnary'
      end
    else
      @game_answer = 'Not included in the grid'
    end
  end

  private
  def check_letters(answer, letters)
    (letters.chars - answer.chars).empty?
  end

  def check_dictionnary(answer)
    response = open("https://wagon-dictionary.herokuapp.com/#{answer}")
    json = JSON.parse(response.read)
    json['found']
  end
end
