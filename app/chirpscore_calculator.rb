class ChirpscoreCalculator
  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
  end

  def calculate(handle)
    if handle.include? " "
      results = "invalid handle"
    else
      tweets = client.user_timeline(handle)
      analyzer = Sentimental.new

      results = tweets.inject(0) { |a, e| a + analyzer.get_score(e.text) }
      results /= tweets.length
      results = sprintf("%0.02f", results * 10)
      results
    end

  end
end

