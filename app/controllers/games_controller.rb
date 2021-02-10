class GamesController < ApplicationController
    def new
        @letters = []
        10.times { @letters << ('A'..'Z').to_a.sample.to_s }
    end

    def score
        raise
    end
end
