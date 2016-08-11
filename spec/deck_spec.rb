require 'deck.rb'
require 'player.rb'

describe Deck do
  let(:player){ Player.new }
  let(:deck){ Deck.new }

  context '#deal_card' do
    it 'reduce the deck cards' do
      deck.deal_card player
      expect(deck.cards.length).to eq(51)
    end
    it 'increase the player cards' do
      deck.deal_card player
      expect(player.cards.length).to eq(1)
    end
  end
end
