class ReviewsController < ApplicationController
  def index 
    @point = Point.find(params[:point_id])
    @items = current_user.items.any_in("point_ids" => [@point.id]) 
  end
end
