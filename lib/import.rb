require 'json'
require 'moped'

session = Moped::Session.new([ "127.0.0.1:27017" ])
session.use :connections_development
consultants = File.read '/Users/Thoughtworker/Documents/consultants.json'
JSON.parse(consultants).each do |consultant|
  session[:consultants].insert(consultant['consultant'])
end
