#!/usr/bin/env ruby

require 'rubygems'  
require 'yaml'

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

def main
  load_config
end


main if __FILE__ == $0
