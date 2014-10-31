require_relative 'creds.rb'
require 'watir-webdriver'

b = Watir::Browser.new

b.goto 'http://football.fantasysports.yahoo.com/pickem'

login_link = b.link :id => 'yucs-login_signIn'
login_link.click

b.text_field( :id => 'username').set($username)
b.text_field( :id => 'passwd').set($password)

b.button( :id => '.save').click

b.link(:text => 'Make your picks').when_present.click

radios = b.radios

radios.each do | r |
  next unless r.enabled?
  b.radios(:name => r.name).to_a.sample.set
  next
end

tiebreaker_scores = b.text_fields(:id => /tiebreak/).each do |t|
  scores = (2..50).to_a.insert(0,0)
  score = scores.sample
  t.set(score.to_s)
end

tb_tmp = b.select_list(:id => 'tb_tmp')
tb_tmp.select tb_tmp.options.to_a.sample.text

tb_tlp = b.select_list(:id => 'tb_tlp')
tb_tlp.select tb_tlp.options.to_a.sample.text

#b.link(:text => 'Save Picks').click




