require "spec_helper"
require_relative "../app/chirpscore_calculator"

RSpec.describe ChirpscoreCalculator do
  describe "#calculate" do
    it "returns 'invalid handle' when the handle has spaces" do
      expect(subject.calculate("bad handle")).to eql("invalid handle")
    end
  end
end
