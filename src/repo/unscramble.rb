module MikeysGames
  class Unscramble
    class Die
      attr_reader :showing

      def initialize(sides)
        @sides = sides
        roll
      end

      def roll
        @showing = @sides.shuffle[0]
      end
    end

    def initialize
      @dice = dice.shuffle
      @board = []
      @dice.each_slice(4) do |row|
         @board << row
      end
    end

    def [](index)
      return @board[index]
    end
    
    def dice
      [
        Die.new(%w{R I F O B X}),
        Die.new(%w{I F E H E Y}),
        Die.new(%w{D E N O W S}),
        Die.new(%w{U T O K N D}),
        Die.new(%w{H M S R A O}),
        Die.new(%w{L U P E T S}),
        Die.new(%w{A C I T O A}),
        Die.new(%w{Y L G K U E}),
        Die.new(%w{Qu B M J O A}),
        Die.new(%w{E H I S P N}),
        Die.new(%w{V E T I G N}),
        Die.new(%w{B A L I Y T}),
        Die.new(%w{E Z A V N D}),
        Die.new(%w{R A L E S C}),
        Die.new(%w{U W I L R G}),
        Die.new(%w{P A C E M D}),
      ]
    end

  end
end