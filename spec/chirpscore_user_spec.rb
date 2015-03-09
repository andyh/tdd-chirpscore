require "spec_helper"
require_relative "../app/chirpscore_user"

RSpec.describe ChirpscoreUser, "with no handle" do
  it "raises an error" do
    expect { ChirpscoreUser.new }.to raise_error(ArgumentError, "missing keyword: handle")
  end
end

RSpec.describe ChirpscoreUser, "with a bad handle" do
  it "raises a 'bad handle' error" do
    expect { ChirpscoreUser.new(handle: "bad handle") }.to raise_error(ChirpscoreError, "invalid handle")
  end
end

RSpec.describe ChirpscoreUser, "with a valid handle" do
  let(:phrases) { ["a happy line", "a sad line", "an indifferent line"]}
  let(:analyzer) { instance_double("SentimentAnalyzer") }
  let(:gateway) { instance_double("TwitterGateway") }
  let(:user) { ChirpscoreUser.new(handle: "elaptics", analyzer: analyzer, gateway: gateway) }

  describe "#score" do
    it "returns a calculated score from the collection of phrases" do
      allow(gateway).to receive(:fetch_phrases).and_return(phrases)
      allow(analyzer).to receive(:get_score).and_return(0.9, -0.25, 0.134)
      expect(user.score).to eq(2.61)
    end
  end

  xdescribe "#phrase" do
    context "for a happy user with a score of 5 or more" do

    end
  end
end

