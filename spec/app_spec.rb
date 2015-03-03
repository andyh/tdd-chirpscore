require 'spec_helper'
require_relative '../app/app'

RSpec.describe 'The Chirpscore App' do
  def app
    Chirpscore
  end

  it "renders the homepage" do
    get '/'
    expect(last_response).to be_ok
  end

  it "renders the chirpscore" do
    allow(ChirpscoreUser).to receive(:fetch).with("faketwitteruser") { instance_double("ChirpscoreUser", :score => "123456789") }
    post '/result', handle: 'faketwitteruser'
    expect(last_response.body).to include '123456789'
  end

  it "renders a detailed chirpscore" do
    allow(ChirpscoreUser).to receive(:fetch).with("faketwitteruser") { instance_double("ChirpscoreUser", :phrase => "faketwitteruser is a fake tweeter with a score of 9876") }
    get "/user/faketwitteruser"
    expect(last_response.body).to include '9876'
  end
end
