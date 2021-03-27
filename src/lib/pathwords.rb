require "singleton"
require_relative "dice"
require_relative "pathwords_player"

class Pathwords
  include Singleton

  attr_accessor :players

  def initialize
    @dice = new_dice.roll
    @board = []
    @players = {}

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

  def add_player(player)
    @players[player.id] = player
  end

  def find_player(id)
    @players[id]
  end

  def player_data
    {
      player_count: @players.size,
    }
  end

  def server_data
    {
      player_count: @players.size,
      players: @players.map { |id, player| player.name }.sort,
    }
  end
end
