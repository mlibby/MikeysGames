module MikeysGames
  class Unscramble
    def initialize
      @board = [
        %w(A B C D E),
        %w(F G H I J),
        %w(K L M N O),
        %w(P Q R S T),
        %w(U V W X Y),
      ]
    end

    def [](index)
      return @board[index]
    end
  end
end