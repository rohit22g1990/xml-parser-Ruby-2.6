require_relative 'abstract_model'

class Shipment < AbstractModel
  def initialize
    super
    @table_name = "shipments"
  end  
end
