class ReviewsController < ApplicationController
  def create
    @point = Point.find(params[:point_id])
    @poi_rec = current_user.poi_recs.where(:point_id => @point.id).first
    @records = @poi_rec.records
        
    @poi_rec.records[0].items
  end
end
