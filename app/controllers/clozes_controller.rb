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
  def create
    @cloze = Cloze.new
    @data = params[:clozes][:file]
    @doc = Nokogiri::XML(@data)
    @error_col = []
#    @doc.at_xpath('item')['xmlns'] = 'http://www.sevgital.com'
    @xsd = Nokogiri::XML::Schema('<?xml version="1.0"?>
                                 <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">
                                 
<xs:element name="item">
    <xs:complexType>
      <xs:all>
        <xs:element name="grade"/>
        
        <xs:element name="text">
          <xs:complexType>
            <xs:sequence>
              <xs:element name="p" maxOccurs="unbounded"/>
            </xs:sequence>
          </xs:complexType>
        </xs:element>

        <xs:element name="questions">
          <xs:complexType>
            <xs:sequence>
              <xs:element name="choices" maxOccurs="unbounded">
                <xs:complexType>
                  <xs:sequence>
                    <xs:element name="choice" maxOccurs="unbounded">
                      <xs:complexType>
                        <xs:simpleContent>
                          <xs:extension base="xs:string">
                            <xs:attribute name="key"/>
                          </xs:extension>
                        </xs:simpleContent>
                      </xs:complexType>
                    </xs:element>
                    <xs:choice minOccurs="0" maxOccurs="unbounded">
                      <xs:element name="tip"/>
                      <xs:element name="type"/>
                      <xs:element name="core"/>
                    </xs:choice>
                  </xs:sequence>
                <xs:attribute name="sn"/>
                </xs:complexType>
              </xs:element>
            </xs:sequence>
          </xs:complexType>
        </xs:element>

      </xs:all>
    </xs:complexType>
</xs:element>

</xs:schema>')
    @xsd.validate(@doc).each do |error|
      @error_col << error.to_s
    end
    @cloze.html = @doc.xpath("item/text").to_xml
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
    @cloze.destroy
    end
  end
end
