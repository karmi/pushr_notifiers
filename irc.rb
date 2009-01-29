require 'rubygems'
require 'shout-bot' # $ sudo gem install sr-shout-bot --source=http://gems.github.com

# = IRC notifications for Pushr (http://github.com/karmi/pushr/)
class Irc < Pushr::Notifier::Base

  def deliver!(notification)
    return unless configured?
    ShoutBot.shout(config['uri'], :as => "Pushr") { |channel| channel.say message(notification) }
  end

  private

  def configured?
    !config['uri'].nil?
  end

end
