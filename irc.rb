require 'rubygems'
require 'shout-bot' # $ sudo gem install sr-shout-bot --source=http://gems.github.com

# = IRC notifications for Pushr (http://github.com/karmi/pushr/)
class Irc < Pushr::Notifier::Base

  attr_reader :config

  def initialize(config={})
    @config = config
    Pushr::Logger::LOGGER.fatal('IRC notifier') { "IRC not configured" } unless configured?
  end

  def deliver!(notification)
    return unless configured?
    message = if notification.success
      "Deployed #{notification.application} with revision #{notification.repository.info.revision} — #{notification.repository.info.message}"
        else
      "FAIL! Deploying #{notification.application} failed. Check log for details."
    end
    ShoutBot.shout(config['uri'], :as => "Pushr") do |channel|
      channel.say message
    end
  end

  private

  def configured?
    !config['uri'].nil?
  end

end
