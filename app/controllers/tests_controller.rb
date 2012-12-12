class TestsController < ApplicationController
  def index
    @clozes = Cloze.all
  end
  def create
    @clozes = Cloze.find(eval(params[:result][:item])) 
      @error_collection = []
    @clozes.each do |cloze|
      @record = Record.new
      @error_count = 0
      @wrong_number = []

      cloze.questions.each do |questions|
        if questions["key"] != params[:result]["cloze_"+cloze.id+"_"+cloze.questions.index(questions).to_s]
          @error_count = @error_count+1 
          @wrong_number << {"index" => cloze.questions.index(questions).to_s, "choc" => params[:result]["cloze_"+cloze.id+"_"+cloze.questions.index(questions).to_s]}

        end
      end

        @error_collection << {"id" => cloze.id, "number" => @wrong_number}

    end


    @record.items = @error_collection
    @record.user_id = current_user.id
    @record.save
  end
end
