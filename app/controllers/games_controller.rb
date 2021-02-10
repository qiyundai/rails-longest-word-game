require 'open-uri'
require 'json'

class GamesController < ApplicationController
    def new
        @letters = []
        10.times { @letters << ('A'..'Z').to_a.sample }
    end

    def score
        provided = params[:letters].split("").select { |i| (i =~ /\W/).nil? }
        dict = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{params[:word].upcase}").read)
        letters = Array.new(params[:word].upcase.split(""))
        matched = letters.map { |letter| !(/#{letter}/ =~ provided.split("").join).nil? ? provided.delete_at(/#{letter}/ =~ provided.join) : nil }
        if dict["found"] && letters.join == matched.join
            @result = "#{params[:word]} is an English word & is from the letters provided. Well Done!"
        elsif dict["found"]
            @result = "#{params[:word]} is an English word but is not from the letters provided. Boo..."
        else
            @result = "#{params[:word]} is not even an English word. Who are you trying to fool!?"
        end
    end
end
