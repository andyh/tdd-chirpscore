require "spec_helper"
require_relative "../app/chirpscore_user"

RSpec.describe ChirpscoreUser do
  subject { ChirpscoreUser.new "bad handle" }
  describe "#score" do
    it "raises 'invalid handle' when the handle has spaces" do
      expect{ subject.score }.to raise_error(ChirpscoreError, "invalid handle")
    end
  end

  xdescribe "#phrase" do
    context "for a happy user with a score of 5 or more" do

    end
  end
end

