require "singleton"
require_relative "dice"
require_relative "pathwords_player"

class Pathwords
  include Singleton

  attr_accessor :players_expected

  def initialize
    @dice = new_dice.roll
    @board = []
    @players = {}
    @players_expected = 0

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

  def player_count
    @players.size
  end

  def set_players_expected(count)
    @players_expected = @players_expected > 0 ? @players_expected : count
  end

  def timer
    nil
  end

  def player_data
    {
      playerCount: @players.size,
      playersExpected: @players_expected,
      timer: timer,
    }
  end

  def server_data
    {
      playerCount: @players.size,
      playersExpected: @players_expected,
      players: @players.map { |id, player| player.name }.sort,
    }
  end
end
