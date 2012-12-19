class ChoicesController < ApplicationController
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
      @point = @choice.points.new
      @point.save
    end
  end
end
