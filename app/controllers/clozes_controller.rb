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
    @doc.xpath("item/questions/choices").each do |choices|
      @cloze_child = @cloze.cloze_children.new
      @cloze_child.position = @doc.xpath("item/questions/choices").index(choices).to_i
      @choice_array = []
      choices.xpath("choice").each do |choice|
        @choice_array << choice.text 
      end
      @cloze_child.choices = @choice_array
      @cloze_child.answer = choices.xpath("choice[@key = '1']").text
      @cloze_child.tips =   choices.xpath("choice/tips").text
      @cloze_child.save
      @point = @cloze_child.points.new
      if choices.xpath("type").text.length > 0
        if choices.xpath("type").text == "word"
          @point.type = "word"
          @point.meaning = choices.xpath("tip").text
          if choices.xpath("core").text.length > 0
            @point.core = choices.xpath("core").text
          else
            @point.core = choices.xpath("choice[@key = '1']").text
          end
        elsif choices.xpath("type").text == "phrase"

          @point.type = "phrase"
          @point.meaning = choices.xpath("tip").text
          if choices.xpath("core").text.length > 0
            @point.core = choices.xpath("core").text
          else
            @point.core = choices.xpath("choice[@key = '1']").text
          end
        else
          @point.type = choices.xpath("type").text
          @point.core = choices.xpath("core").text
        end
      else
        @point.type = "word"
        @point.meaning = choices.xpath("tip").text
        if choices.xpath("core").text.length > 0
          @point.core = choices.xpath("core").text
        else
          @point.core = choices.xpath("choice[@key = '1']").text
        end
      end
      @point.save
    end  
=begin
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
=end
    if @cloze.save
      render :text => "OK"
    end
  end
end
