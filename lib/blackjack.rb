require_relative 'human.rb'
require_relative 'player.rb'
require_relative 'dealer.rb'
require_relative 'deck.rb'

class Game
  def initialize deck: Deck.new, player: Player.new, dealer: Dealer.new
    @deck = deck
    @player = player
    @dealer = dealer
    @cur = nil
  end

  def play
    shuffle_cards
    loop do

      break if game_over?
    end
  end

  def shuffle_cards
    2.times { @deck.deal_card @player }
    2.times { @deck.deal_card @dealer }
  end

end
