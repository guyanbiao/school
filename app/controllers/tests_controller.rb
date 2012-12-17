class TestsController < ApplicationController
  def practice
    @point = Point.find(params[:id])
    @cloze_children = @point.cloze_children
  end
  def index
    @relation = Proc.new do |str| 
      case str
      when "cloze"
        @clozes = Cloze.all.limit(5)
      when "choice"
        @choices = Choice.all.limit(5)
      when "reading"
        @reading = Reading.all.limit(5)
      end
    end
    params[:model] ||= []
    if params[:model].length == 0 || params[:model].length == 3
     # instance_variable_set("@"+"clozes", Cloze.all.limit(5))
      @relation.call "cloze"
    else 
      params[:model].each do |picker|
        @relation.call picker
      end
    end
  end
  def create
    
    @clozes = Cloze.find(eval(params[:result][:item])) 
    @error_collection = []
    @clozes.each do |cloze|
      @record = current_user.records.new

      cloze.cloze_children.each do |questions|
        if questions["answer"] != params[:result]["cloze_"+cloze.id+"_"+questions["position"].to_s]
          @record.push(:cloze_child_ids, questions.id)
          questions.push(:record_ids, @record.id)
          @before_collection = []

          questions.points.each do |point|
            @before_collection << point.id
            if Ranking.where("point_id" => point.id).exists?
              @ranking = Ranking.where("point_id" => point.id).first
              @ranking.score = @ranking.score - 1
            else
              @ranking = Ranking.new
              @ranking.user_id = current_user.id
              @ranking.point_id = point.id
              @ranking.score = @ranking.score - 1
            end
            @ranking.save

            if PoiRec.all_of(:user_id => current_user.id, :point_id => point.id).exists?
              PoiRec.all_of(:user_id => current_user.id, :point_id => point.id).first.push(:record_ids, @record.id)
            else
            @poi_rec = current_user.poi_recs.new
            @poi_rec.point_id = point.id
            @poi_rec.push(:record_ids, @record.id) 
            @poi_rec.save
            end
          end

          @error_collection << {"child_id" => questions.id, "point_ids" => @before_collection, "choice" => params[:result]["cloze_"+cloze.id+"_"+ questions["position"].to_s]}
        else
          questions.points.each do |point|
            if Ranking.where("point_id" => point.id).exists?
              @ranking = Ranking.where("point_id" => point.id).first
              @ranking.score = @ranking.score + 1
            else
              @ranking = Ranking.new
              @ranking.user_id = current_user.id
              @ranking.point_id = point.id
              @ranking.score = @ranking.score + 1
            end
            @ranking.save
          end
        end
      end


      @record.items = @error_collection
      @record.save
    end
  end
end
