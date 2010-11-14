#!/usr/bin/env ruby

require 'rubygems'  
require 'yaml'

# load configuration
CONFIG_YAML = File.expand_path(File.join(File.dirname(__FILE__), 'minder.yaml'))
config = YAML::load(File.read(CONFIG_YAML))

$user = config['xmpp_from']['user']
$pass = config['xmpp_from']['pass']
$recipient = config['xmpp_to']

$domains = config['domains']
