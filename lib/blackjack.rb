require_relative 'human.rb'
require_relative 'player.rb'
require_relative 'dealer.rb'
require_relative 'deck.rb'
require 'pry-byebug'

class Game
  def initialize deck: Deck.new, player: Player.new, dealer: Dealer.new
    @deck = deck
    @player = player
    @dealer = dealer
    @dealer_finish = false
  end

  def play
    loop do
      break if bankrupt?
      reshuffle
      player_bet
      shuffle_cards
      loop do
        # binding.pry
        show_board
        break if game_over?
        puts "Hit or stay?"
        command = gets.chomp
        follow command
      end
      show_result
    end
    puts "You fucking bankrupt!"
  end

  def bankrupt?
    @player.bank <= 0
  end

  def player_bet
    puts "how much do you bet?(You have $#{@player.bank} left. )"
    bet = gets.chomp
    exit if bet.downcase == 'q'
    @player.bet = bet.to_i
  end

  def reshuffle
    @deck = Deck.new
    @player.cards = []
    @dealer.cards = []
    @dealer_finish = false
  end

  def shuffle_cards
    2.times { @deck.deal_card @player }
    2.times { @deck.deal_card @dealer }
  end

  def show_board
    puts "Player cards: "
    @player.cards.each { |card| puts card }
    puts "Dealer card"
    @dealer.cards.each { |card| puts card }
  end

  def follow command
    if command == 'hit'
      @deck.deal_card @player
    elsif command == 'stay'
      dealer_action
    else
      raise 'Wrong input'
    end
  end

  def game_over?
    @player.bust ||
    @dealer.bust ||
    dealer_finish? ||
    player_bj? ||
    dealer_bj?
  end

  def dealer_finish?
    @dealer_finish
  end

  def player_bj?
    @player.cards_sum == 21 &&
    @player.cards.length == 2
  end

  def dealer_bj?
    @dealer.cards_sum == 21 &&
    @dealer.cards.length == 2
  end

  def show_result
    if player_win? && player_bj?
      puts "BOOM BLACKJACK, mother fucker!"
      @player.bank += @player.bet * 1.5
    elsif dealer_win?
      puts "You lose, mother fucker!"
      @player.bank -= @player.bet
    elsif player_win?
      @player.bank += @player.bet
      puts "You win!, mother fucker!"
    else
      puts "Even game, mother fucker!"
    end
  end

  def player_win?
    @dealer.bust ||
    (@player.cards_sum > @dealer.cards_sum && !@player.bust)
  end

  def dealer_win?
    @player.bust ||
    (@player.cards_sum < @dealer.cards_sum && !@dealer.bust)
  end

  def dealer_action
    loop do
      break if @dealer.over_17?
      @deck.deal_card @dealer
    end
    @dealer_finish = true
  end


end

new_game = Game.new
new_game.play
