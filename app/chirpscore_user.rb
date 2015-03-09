require_relative "twitter_gateway"
require_relative "sentiment_gateway"

class ChirpscoreError < StandardError; end

class ChirpscoreUser
  attr_reader :handle

  def initialize handle:, gateway: TwitterGateway.new, analyzer: SentimentAnalyzer.new
    raise(ChirpscoreError, "invalid handle") if handle.include?(" ")
    @handle   = handle
    @gateway  = gateway
    @analyzer = analyzer
  end

  def self.fetch handle
    new handle: handle
  end

  def score
    tweets = gateway.fetch_phrases(handle)
    results = tweets.inject(0.0) { |a, e| a + analyzer.get_score(e) } / tweets.length
    sprintf("%0.02f", results * 10).to_f
  end

  def phrase
    mood = score.to_f > 0 ? "ecstatic" : "irritated"
    "#{handle[1..-1]} is an #{mood} tweeter with a score of #{score}"
  end

  private
  attr_reader :gateway, :analyzer
end


