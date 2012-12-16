module AnalyticsHelper
  
    class Fuck
      def initialize(k,x)
        @kind = k
        @pre = x
      end
      def first 
        'link_to "Edit", edit_point_path("'+@kind+'")'
      end
      def second
        'link_to "Practice", practice_tests_path(:id => "'+@kind+'")'
      end
      def third
        'link_to "Learn", point_path("'+@kind+'")'
      end
      def show
        'link_to "Show history", reviews_path(:point_id => "'+@kind+'"), :method => :post '
      end
      def pre 
        case @pre
        when "distinguish phrase"
          "analytics.index.diffrence"
        when "grammar"

          "analytics.index.ausage"
        else
          "analytics.index.usage"
        end
      end
    end
  def show_resourse(point)
    test = Fuck.new point.id, point.type 
    return test
  end
end
