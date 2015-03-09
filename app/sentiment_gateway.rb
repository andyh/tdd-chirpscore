require "sentimental"


class SentimentAnalyzer
  def initialize
    Sentimental.load_defaults
    @analyzer = Sentimental.new
  end

  def get_score(phrase)
    analyzer.get_score(phrase)
  end

  private
  attr_reader :analyzer
end
