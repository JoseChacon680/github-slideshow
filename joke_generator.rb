#!/usr/bin/env ruby

require 'net/http'
require 'json'

class JokeGenerator
  API_URL = 'https://official-joke-api.appspot.com/random_joke'

  def self.fetch_joke
    uri = URI(API_URL)
    response = Net::HTTP.get(uri)
    joke_data = JSON.parse(response)
    
    format_joke(joke_data)
  end

  private

  def self.format_joke(joke_data)
    setup = joke_data['setup']
    punchline = joke_data['punchline']
    joke_type = joke_data['type']
    
    puts "╔════════════════════════════════════════╗"
    puts "║  📝 Random Joke Generator 📝          ║"
    puts "╠════════════════════════════════════════╣"
    puts "║ Type: #{joke_type.capitalize.ljust(31)} ║"
    puts "╠════════════════════════════════════════╣"
    puts "║                                        ║"
    puts "║ #{format_text(setup, 36)}                ║"
    puts "║                                        ║"
    puts "╠════════════════════════════════════════╣"
    puts "║ #{format_text(punchline, 36)}                ║"
    puts "║                                        ║"
    puts "╚════════════════════════════════════════╝"
  end

  def self.format_text(text, max_width)
    if text.length <= max_width
      text.ljust(max_width)
    else
      # Split text into multiple lines if needed
      lines = text.scan(/.{1,#{max_width}}/)
      lines.join("\n║ ")
    end
  end
end

# Usage
if __FILE__ == $PROGRAM_NAME
  begin
    JokeGenerator.fetch_joke
  rescue => e
    puts "❌ Error fetching joke: #{e.message}"
    puts "Make sure you have an internet connection."
  end
end
