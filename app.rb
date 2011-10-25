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

WEASELS = ["fairly","substantial","various","very","few","relatively","quite","huge","relatively"]

class String
  def weasel?
    WEASELS.include? self
  end
end
  

class Essay
  attr_reader :stats
  attr_reader :mark
  attr_reader :weasels
  
  def initialize(text)
    @text = text
    @mark = 1
    @words = 0
    @weasels = 0
  end
  
  def analyse
    words = @text.split(/[^a-zA-Z]/)
    
    words.each do | word |
      if word.weasel?
        @weasels = @weasels + 1
      end
    end
    
    @words = words.length
    
    if @words > 0
      score
    end
  end
  
  def words
    @words
  end
  
  def text_classification
    if @mark > 0
      '<span class="fine">fine</span>'
    #elsif @mark == 1
    #s  '<span class="ok">not great</span>'
    else
      '<span class="bullshit">definitely bullshit</span>'
    end
  end
  
  private
    def score
      if (@weasels / @words) > 0.1
        @mark = @mark - 1
      end
    end
end