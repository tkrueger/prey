$:.unshift File.join(File.dirname(__FILE__), '../src')

require 'game'

class Main

  puts "starting Game..."
  game = Game.new
  game.start
end