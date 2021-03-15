require "singleton"
require_relative "dice"

module MikeysGames
  class Pathwords
    include Singleton

    def initialize
      @dice = new_dice.roll
      @board = []
      @dice.each_slice(4) do |row|
        @board << row
      end
    end

    def [](index)
      @board[index]
    end

    def new_dice
      Dice.new [
        %w[R I F O B X],
        %w[I F E H E Y],
        %w[D E N O W S],
        %w[U T O K N D],
        %w[H M S R A O],
        %w[L U P E T S],
        %w[A C I T O A],
        %w[Y L G K U E],
        %w[Qu B M J O A],
        %w[E H I S P N],
        %w[V E T I G N],
        %w[B A L I Y T],
        %w[E Z A V N D],
        %w[R A L E S C],
        %w[U W I L R G],
        %w[P A C E M D],
      ]
    end
  end
end
