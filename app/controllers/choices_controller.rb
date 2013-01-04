class ChoicesController < ApplicationController
  def update
    @choice = Choice.find(params[:id])
    @choice.update_attributes(params[:choice])
  end
  def edit
    @choices = Choice.where(passed: false).limit(1).order_by([[:created_at, :desc]])
  end
  def index
    @choice = Choice.new
  end
  def create
    @doc = Nokogiri::XML(params[:choice][:file])
    @doc.xpath("mc/item").each do |item|
      @choice = Choice.new
      @choice.text = item.xpath("text").text
      @choice.tips = item.xpath("tips").text
      @choice_array = item.xpath("choice").map {|x| x.text}
      @choice.choices = @choice_array
      @choice.answer = item.xpath("choice[@key = '1']").text
      @choice.save 
    end
  end
end
