require_relative 'abstract_model'

class Activity < AbstractModel
  def initialize
    super
    @table_name = "activities"
  end  
end
