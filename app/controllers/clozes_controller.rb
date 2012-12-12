class ClozesController < ApplicationController
  def index
    @cloze = Cloze.new
  end
  def create
    @cloze = Cloze.new
    @data = params[:cloze][:file]
    @doc = Nokogiri::XML(@data)
    #    @cloze.text = Hash.from_xml(@data.xpath("item/text").to_xml)
    #    @cloze.text = Hash.from_xml(params[:cloze][:file].read)
    @cloze.text = @doc.xpath("item/text").to_xml
    @cloze.grade = @doc.xpath("item/grade").text.to_i
    @question_data = []
    @doc.xpath("item/questions/choices").each do |choices|

      @choice_data =[]
      choices.xpath("choice").each do |item|
        @choice_data << item.text
      end
      @question_data << {
        :choices => @choice_data,
        :key => choices.xpath("choice[@key= '1']").text,
        :tips => choices.xpath("tips").text,
        :point => choices.xpath("point").text
      }
    end
    @cloze.questions = @question_data
    if @cloze.save
      render :text => "OK"
    end
  end
end
