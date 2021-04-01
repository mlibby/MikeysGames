class Pathwords
  class Player
    attr_accessor :ready_next
    attr_reader :id, :name

    def initialize(id, name)
      @id = id
      @name = name
      @ready_next = false
    end
  end
end
