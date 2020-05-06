require_relative 'abstract_model'

class Package < AbstractModel
  def initialize
    super
    @table_name = "packages"
  end  
end
