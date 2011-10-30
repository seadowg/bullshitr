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


class String
  WEASELS = ["fairly","substantial","various","very","few","relatively","quite","huge","relatively","interestingly"]
    
  def weasel?
    WEASELS.include? self
  end
end
  
class Essay
  HIGH_SCORE = 1
  
  attr_reader :stats
  attr_reader :mark
  attr_reader :count
  
  def initialize(text)
    @text = text
    
    @mark = HIGH_SCORE
    
    @count = Hash.new(0)
  end
  
  def tokens
    @tokens ||= @text.split(/[^a-zA-Z]/)
  end
  
  def analyse    
    tokens.each do |word|
      count[:words] += 1
      count[:weasels] += 1 if word.weasel?
    end
        
    score if count[:words] > 0
  end
  
  def text_classification
    case
      when mark > (HIGH_SCORE / 2)
        '<span class="fine">fine</span>'
      when mark > 0
        '<span class="ok">not great</span>'
      else
        '<span class="bullshit">bullshit</span>'
    end
  end
  
  private
    def score
      excessive_weasels = (count[:weasels] / Float(count[:words])) > 0.05
      @mark -= 1 if excessive_weasels
    end
end