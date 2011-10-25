require 'sinatra'

class Bullshitr < Sinatra::Base
  get "/" do
    erb :index
  end
  
  post "/essay" do
  end
end