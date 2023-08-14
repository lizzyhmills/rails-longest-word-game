class GamesController < ApplicationController

  # require "json"
  # require "open-uri"

  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @totalscore = 0
    if involve? && valid?
      @totalscore += params[:word].length
    @answer = "Congratulations! #{params[:word]} is an English word! Your score is #{params[:word].length}."
    elsif involve?
      @answer = "Sorry but #{params[:word].upcase} does not seem to be an English word."
    else
      @answer = "Sorry but #{params[:word].upcase} cannot be built out of #{@letters}"
    end
  end

  def involve?
    @letters = params[:letters].split
    @words = params[:word].chars
    return @words.all? { |e| @letters.include?(e) }
  end

  def valid?
    @url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    word_validator = URI.open(@url).read
    @wordvalid = JSON.parse(word_validator)
    return @wordvalid["found"]
  end

end
