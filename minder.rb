#!/usr/bin/env ruby

require 'rubygems'  
require 'yaml'
require 'xmpp4r-simple'
require 'open-uri'
require 'timeout'

TIMEOUT = 10 # max time to attempt to access each domain

# globals
$user = nil
$pass = nil
$recipient = nil
$domains = []

def load_config
  # load the YAML
  config_file = File.expand_path(File.join(File.dirname(__FILE__), 'minder.yaml'))
  config = YAML::load(File.read(config_file))
  # populate globals
  $user = config['xmpp_from']['user']
  $pass = config['xmpp_from']['pass']
  $recipient = config['xmpp_to']
  $domains = config['domains']
end

def message(msg)
  jabber = Jabber::Simple.new($user, $pass)
  jabber.deliver($recipient, msg)
  sleep 1
end

def can_read_domain?(domain)
  print "Checking #{domain}: "
  url = "http://#{domain}/"
  begin 
    Timeout::timeout(TIMEOUT) do
      open(url, 'Cache-Control' => 'no-cache').read
    end
  rescue Timeout::Error
    puts 'down!'
    false
  else
    puts 'ok'
    true
  end
end

# attempt to access each domain, send XMPP message if can't
def main
  load_config
  $domains.each do |domain|
    unless can_read_domain? domain
      message "#{domain} is down!"
    end
  end
end


main if __FILE__ == $0
