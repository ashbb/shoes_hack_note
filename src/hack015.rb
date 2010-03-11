# hack015.rb
require 'mechanize'

Shoes.app do
  Agent = WWW::Mechanize.new
  page = Agent.get('http://www.rubylearning.org/class/')
  para page.body
end
