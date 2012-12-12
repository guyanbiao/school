class ImportsController < ApplicationController
  def create
    @import = Import.new
    @data = params[:import][:file]
    @doc = Nokogiri::XML(@data)
#    @import.text = Hash.from_xml(@data.xpath("item/text").to_xml)
#    @import.text = Hash.from_xml(params[:import][:file].read)
    @import.text = @doc.xpath("item/text").to_xml
    @import.grade = @doc.xpath("item/grade").text.to_i
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
    @import.questions = @question_data
    @import.save
  end
end
