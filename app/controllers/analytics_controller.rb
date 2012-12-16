class AnalyticsController < ApplicationController
  def index
    @ranking = current_user.rankings.all.order_by([[:score, :asc]])
  end
end
