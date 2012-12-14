class AnalyticsController < ApplicationController
  def index
    @points = current_user.rankings.limit(5).all.order_by([[:score, :asc]])
  end
end
