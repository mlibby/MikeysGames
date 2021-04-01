require "singleton"
require_relative "dice"
require_relative "pathwords_player"

class Pathwords
  include Singleton

  attr_accessor :players_expected, :stage

  def initialize
    @dice = new_dice.roll
    @board = []
    @board_cache = []
    @players = {}
    @players_expected = 0
    @players_ready = 0
    @timer = 0

    #stages are:
    # 0 - gathering players
    # 1 - pre-game timer
    # 2 - in-game
    # 3 - post-game
    @stage = 0
    @round = 0

    @dice.all.each_slice(4) do |row|
      @board << row
    end
  end

  def get_letter(row, col)
    if @stage >= 2
      @board[row][col].showing
    else
      "⁕"
    end
  end

  def cache_board
    @board_cache = @board.map do |row|
      row.map { |die| die.showing }
    end
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
    if @players.size == @players_expected
      @stage = 1
      @timer = Time.now + 10
    end
  end

  def find_player(id)
    @players[id]
  end

  def player_count
    @players.size
  end

  def set_players_expected(count)
    count = count.to_i
    if count < @players.size
      @players_expected = @players.size
    else
      @players_expected = count
    end
  end

  def player_next(id)
    @players[id].ready_next = true
    @players_ready = @players.select{|id,player| player.ready_next }.size
    if @players_ready == @players_expected
      start_next_round
    end
  end

  def start_next_round
    @players.each do |player|
      player.ready_next = false
    end
    @round += 1
    @stage = 1
  end

  def get_timer
    if @timer == 0
      return 0
    end

    now = Time.now
    if @timer < now
      @stage += 1
      if @stage == 3
        @timer = 0
      elsif @stage == 2
        @dice.roll
        cache_board
        # very short games for testing
        @timer = now + 30
        #@timer = now + 180
      end
    end

    @timer == 0 ? 0 : (@timer - now).round
  end

  def player_data
    {
      board: @board_cache,
      playerCount: @players.size,
      playersExpected: @players_expected,
      playersReady: @players_ready,
      stage: @stage,
      timer: get_timer,
    }
  end

  def server_data
    {
      board: @board_cache,
      playerCount: @players.size,
      playersExpected: @players_expected,
      playersReady: @players_ready,
      players: @players.map { |id, player| player.name }.sort,
      stage: @stage,
      timer: get_timer,
    }
  end
end
