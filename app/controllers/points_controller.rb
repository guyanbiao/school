class PointsController < ApplicationController
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
    redirect_to "/analytics"
  end
end
