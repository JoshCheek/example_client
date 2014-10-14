require_relative '../client'
require_relative '../models'
require_relative '../app'
require 'rack/test'

RSpec.describe Client do
  let(:session)  { Rack::Test::Session.new(App) }
  let(:internet) { Client::Internet::Rack.new(session) }
  let(:client)   { Client::UserRepository.new(internet) }

  it 'can get a given user' do
    app_user = User.create! name: 'Tim'

    client_user = client.find(app_user.id)
    expect(client_user.name).to eq app_user.name
  end
end
