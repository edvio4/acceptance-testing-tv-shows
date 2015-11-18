require 'sinatra'
require 'csv'
require_relative "app/models/television_show"

set :views, File.join(File.dirname(__FILE__), "app/views")

get '/television_shows' do
  tv_shows = TelevisionShow.all
  erb :index, locals: { tv_shows: tv_shows }
end

get '/television_shows/new' do
	tv_show = TelevisionShow.new
	erb :new, locals: { tv_show: tv_show }
end

post '/television_shows/new' do
  tv_show = TelevisionShow.new(params["tv_show"])
  if tv_show.save
	    redirect '/television_shows'
	else
	  erb :new, locals: { tv_show: tv_show }
	end
end
