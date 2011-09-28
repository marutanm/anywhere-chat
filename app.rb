# coding: utf-8

Pusher.app_id ||= ENV['APP_ID']
Pusher.key ||= ENV['KEY']
Pusher.secret ||= ENV['SECRET']

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

get '/:name.css' do
  # content_type 'text/css', :charset => 'utf-8'
  scss :"#{params[:name]}"
end

get '/script.js' do
  coffee :script
end

get '/' do
  haml :index
end

post '/' do
  Pusher['test_channel'].trigger('my_event', params)
end
