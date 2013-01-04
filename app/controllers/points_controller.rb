class PointsController < ApplicationController
  autocomplete :type, :types
  autocomplete :point, :core
  def build
    @model_name = params[:model_name]
    @father_id = params[:id]
    @point = Point.new
  end
  def create
      @point =  Point.all_of(:core => params[:point][:core], :type => params[:point][:type]).first || Point.create(params[:point])

    case params[:model_name]
    when 'cloze'
      @cloze_child = ClozeChild.find(params[:father_id])
      @cloze_child.push(:point_ids, @point.id)
      #TODO validate whether point has exist.
      @point.push(:cloze_child_ids, @cloze_child.id)
      @type = Type.find_or_create_by(types: params[:point][:core])
      redirect_to edit_clozes_path
    when 'choice'
      @choice = Choice.find(params[:father_id])
      @choice.push(:point_ids, @point.id)
      @point.push(:choice_ids, @cloze_child.id)
      @type = Type.find_or_create_by(types: params[:point][:core])
      redirect_to edit_choices_path
    
    end
  end

  def show
    @point = Point.find(params[:id])
  end
  def edit
    @point = Point.find(params[:id])

  end
  def update
    @point = Point.find(params[:id])
    @point.wiki = params[:point][:wiki]
    @point.save
    redirect_to "/clozes/edit"
  end
end
