class Player < Human
  attr_accessor :bank, :bet

  def initialize
    super
    @bank = 2000
    @bet = 100
  end

end
