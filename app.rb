require 'sinatra'

class Bullshitr < Sinatra::Base
  get "/" do
    erb :index
  end
  
  post "/essay" do
    @essay = Essay.new(params[:textarea])
    @essay.analyse
    erb :essay
  end
  
end

class Essay
  attr_reader :stats
  
  def initialize(text)
    @text = text
    @stats = {}
  end
  
  def analyse
    @text.split(/[^a-zA-Z]/).each do | word |
      word_count(word)
    end
  end
  
  private
    def word_count(word)
      @stats[:word_count] = (@stats[:word_count] || 0) + 1
    end
end