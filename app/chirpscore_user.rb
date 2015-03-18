require_relative "twitter_gateway"
require_relative "sentiment_gateway"

class ChirpscoreError < StandardError; end

class ChirpscoreUser
  attr_reader :handle

  def initialize handle:, gateway: TwitterGateway.new, analyzer: SentimentAnalyzer.new
    raise(ChirpscoreError, "invalid handle") if handle.include?(" ")
    @handle   = normalize(handle)
    @gateway  = gateway
    @analyzer = analyzer
    raise(ChirpscoreNotFound, "handle does not exist") unless check_handle_existence
  end

  def self.fetch handle
    new handle: handle
  end

  def score
    return @score if @score
    tweets = gateway.fetch_phrases(handle)
    results = tweets.inject(0.0) { |a, e| a + analyzer.get_score(e) } / tweets.length
    @score = sprintf("%0.02f", results * 10).to_f
  end

  def phrase
    mood = score > 0 ? "ecstatic" : "irritated"
    "#{handle} is an #{mood} tweeter with a score of #{score}"
  end

  private
  attr_reader :gateway, :analyzer

  def check_handle_existence
    gateway.handle_exists?(handle)
  end

  def normalize(raw_handle)
    raw_handle.gsub("@","")
  end
end


