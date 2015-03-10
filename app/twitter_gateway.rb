require "twitter"

class ChirpscoreNotFound < StandardError; end

class TwitterGateway
  def fetch_phrases(handle)
    client.user_timeline(handle).collect(&:text)
  end

  def handle_exists?(handle)
    if client.user(handle)
      return true
    end
  rescue Twitter::Error::NotFound
    return false
  end

  private

  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV.fetch("TWITTER_CONSUMER_KEY")
      config.consumer_secret     = ENV.fetch("TWITTER_CONSUMER_SECRET")
      config.access_token        = ENV.fetch("TWITTER_ACCESS_TOKEN")
      config.access_token_secret = ENV.fetch("TWITTER_ACCESS_TOKEN_SECRET")
    end
  end

end
