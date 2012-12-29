class PointsController < ApplicationController
  def build
    @cloze_child = ClozeChild.find(params[:id])
    @point =  Point.new
    @cloze_child.push(:point_ids, @point.id)
  end
  def create
    @point = Point.new(params[:point])
    @point.save
    render :json => params
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
