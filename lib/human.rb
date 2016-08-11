class Player
  attr_accessor :bank, :bet, :cards

  def initialize
    @bank = 2000
    @bet = 100
    @cards = []
  end
end
