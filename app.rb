# coding: utf-8

Pusher.app_id ||= ENV['APP_ID']
Pusher.key ||= ENV['KEY']
Pusher.secret ||= ENV['SECRET']

configure do
  uri = URI.parse(ENV["REDISTOGO_URL"])
  REDIS = Redis.new(:host => uri.host, :port => uri.port)
end

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
  REDIS.lpush(:key, params.to_json)
  Pusher['test_channel'].trigger('my_event', params)
end

get '/log' do
  REDIS.lrange(:key, 0, 99).to_json
end
