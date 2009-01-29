require 'rubygems'
require 'shout-bot' # $ sudo gem install sr-shout-bot --source=http://gems.github.com

# = IRC notifications for Pushr (http://github.com/karmi/pushr/)
class Irc < Pushr::Notifier::Base

  attr_reader :config

  def initialize(config={})
    @config = config
    puts "OK, IRC initialized with config #{@config.inspect}"
  end

  def deliver!
    ShoutBot.shout(config['uri'], :as => "Pushr") do |channel|
      channel.say "Testing...."
    end
  end
end