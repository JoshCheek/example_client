require 'sinatra/base'
require 'stringio'
require 'logger'

require_relative 'models'

class App < Sinatra::Base
  enable :inline_templates

  get '/users/:id' do
    content_type :json
    User.find(params[:id]).to_json
  end
end
