$stdout.sync = true
require "dotenv"
require "haml"
require_relative "chirpscore_user"

ENV["RACK_ENV"] ||= "development"
APP_ENV = ENV.fetch("RACK_ENV")
Dotenv.load(
  File.expand_path("../../.#{APP_ENV}.env", __FILE__),
  File.expand_path("../../.env",  __FILE__))
require "sinatra/base"

class Chirpscore < Sinatra::Base
  get '/' do
    haml :index, format: :html5
  end

  post '/result' do
    user   = ChirpscoreUser.fetch(params[:handle])
    @score = user.score
    haml :result, format: :html5
  end

  get "/user/:handle" do
    user    = ChirpscoreUser.fetch(params[:handle])
    @phrase = user.phrase
    haml :user, format: :html5
  end

  error ChirpscoreError do
    status 400
    env['sinatra.error'].message
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
