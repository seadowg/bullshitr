require 'sinatra'

class Bullshitr < Sinatra::Base
  get "/" do
    erb :index
  end
  
  post "/essay" do
    @essay = Essay.new(params[:text])
    @essay.analyse
    erb :essay
  end
  
end

class Essay
  attr_reader :stats
  attr_reader :mark
  
  def initialize(text)
    @text = text
    @stats = {}
    @mark = 1
  end
  
  def analyse
    @text.split(/[^a-zA-Z]/).each do | word |
      word_count(word)
    end
    
    if @stats[:word_count] > 10000
      @mark = @mark - 1
    end
  end
  
  def text_classification
    if @mark > 0
      '<span class="fine">fine</span>'
    else
      '<span class="bullshit">definitely bullshit</span>'
    end
  end
  
  private
    def word_count(word)
      @stats[:word_count] = (@stats[:word_count] || 0) + 1
    end
end