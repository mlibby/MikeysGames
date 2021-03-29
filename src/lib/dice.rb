class Die
  attr_reader :showing

  def initialize(sides)
    @sides = sides
    @showing = @sides[0]
  end

  def roll
    @showing = @sides.shuffle[0]
  end
end

class Dice
  def initialize(dice)
    @dice = []

    dice.each do |die|
      @dice << Die.new(die)
    end

    roll
  end

  def all
    @dice
  end

  def roll
    @dice.each { |die| die.roll }
    @dice.shuffle!
    self
  end
end
