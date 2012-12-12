class TestsController < ApplicationController
  def index
    @cloze = Cloze.first
  end
  def create
   @cloze = Cloze.find(params[:result][:item]) 
    
  end
end
