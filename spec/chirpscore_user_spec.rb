require "spec_helper"
require_relative "../app/chirpscore_user"

RSpec.describe ChirpscoreUser, "with no handle" do
  it "raises an error" do
    expect { ChirpscoreUser.new }.to raise_error(ArgumentError)
  end
end

RSpec.describe ChirpscoreUser, "with a bad handle" do
  it "raises a 'bad handle' error" do
    expect { ChirpscoreUser.new("bad handle") }.to raise_error(ChirpscoreError, "invalid handle")
  end
end

RSpec.describe ChirpscoreUser, "with a valid handle" do
  describe "#score" do
    xit "returns a number"
  end

  xdescribe "#phrase" do
    context "for a happy user with a score of 5 or more" do

    end
  end
end

