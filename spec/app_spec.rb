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
    allow_any_instance_of(ChirpscoreCalculator).to receive(:calculate).with('faketwitteruser') { '123456789' }
    get "/user/faketwitteruser"
    expect(last_response).to be_ok
  end
end
