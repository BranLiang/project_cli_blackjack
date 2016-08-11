# project_cli_blackjack
Hit me!

## Pseudo code

```ruby
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
```
