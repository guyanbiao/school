class LearnsController < ApplicationController
  def index
    @explain = Point.find(params[:point_id]).wiki
  end
end
