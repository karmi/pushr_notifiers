require 'rubygems'
require 'xmpp4r'

# = Jabber notifications for Pushr (http://github.com/karmi/pushr/)
# Buy http://peepcode.com/products/xmpp from Topfunky!
class Pushr::Notifier::Jabber < Pushr::Notifier::Base

  def deliver!(notification)
    return unless configured?

    jid    = Jabber::JID.new(config['username'])
    client = Jabber::Client.new(jid)
    client.connect

    client.auth(config['password'])
    client.send(Jabber::Presence.new.set_status("Pushr at #{Time.now.utc}"))

    msg      = Jabber::Message.new(config['username'], message(notification))
    msg.type = :normal
    client.send(msg)

    client.close
  end

  private

  def configured?
    !config['username'].nil? && !config['password'].nil?
  end

end