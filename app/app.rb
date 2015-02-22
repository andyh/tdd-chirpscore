$stdout.sync = true
require "dotenv"
require "sentimental"
require "twitter"
require "haml"
require_relative "chirpscore_calculator"

ENV["RACK_ENV"] ||= "development"
APP_ENV = ENV.fetch("RACK_ENV")
Sentimental.load_defaults
Dotenv.load(
  File.expand_path("../../.#{APP_ENV}.env", __FILE__),
  File.expand_path("../../.env",  __FILE__))
require "sinatra/base"

class Chirpscore < Sinatra::Base
  def calculator
    ChirpscoreCalculator.new
  end
  get '/' do
    haml :index, format: :html5
  end

  post '/result' do
    @result = calculator.calculate(params[:handle])
    haml :result, format: :html5
  end

  get "/user/:handle" do
    haml :user, format: :html5
  end
  # start the server if ruby file executed directly
  run! if app_file == $0
end
