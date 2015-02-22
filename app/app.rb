$stdout.sync = true
require "dotenv"
require "sentimental"
require "twitter"
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
    <<EOS
    <form method="post" action="/result">
      <input type=text name=handle />
      <input type=submit value='go go go!!!!' />
    </form>
EOS
  end

  post '/result' do
    <<EOS
    <html>
        <body>
    #{calculator.calculate(params[:handle])}
        </body>
    </html>
EOS
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
