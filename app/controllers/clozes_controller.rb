#-- coding: utf-8 --
class ClozesController < ApplicationController
  def update
    @cloze = Cloze.find(params[:id]) 
    @cloze.update_attributes(params[:cloze])
  end
  def edit
    @clozes = Cloze.limit(1).order_by([[:created_at, :desc]])
  end
  def index
    
  end
  
  def create_list
    @data = params[:clozes][:file]
    #@doc = Nokogiri::XML(@data)
    data_json = @data.read.split ' ' 
    data_json.each_slice(2) do |a|
      WordFre.create!(:word => a[1], :fre => a[0])
    end 
    render text: WordFre.all.count
  end



  def create
    @cloze = Cloze.new
    @data = params[:clozes][:file]
    @doc = Nokogiri::XML(@data)
    @error_col = []
#    @doc.at_xpath('item')['xmlns'] = 'http://www.sevgital.com'
#    @xsd.validate(@doc).each do |error|
#      @error_col << error.to_s
#    end
    @cloze.html = @doc.xpath("item/text").to_xml

    signature = @doc.xpath("item/text").text





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
    end  

    if @error_col == []
    @cloze.save
    flash[:notice] = 'New cloze item created successfully'
    redirect_to '/home'
#    render :text => 'ok'
    else
    render :json => @error_col
    end
  end
end
