class HomeController < ApplicationController
  def index
    @import = Import.new
  end
end
