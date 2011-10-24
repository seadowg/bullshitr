require 'sinatra'

class Bullshitr < Sinatra::Base
  get "/" do
    erb :help
  end
end