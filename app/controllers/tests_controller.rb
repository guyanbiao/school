class TestsController < ApplicationController
  def index
    @clozes = Cloze.all
  end
  def create
   @clozes = Cloze.find(eval(params[:result][:item])) 
    
  end
end
