require_relative 'controller/shipping_controller'

class Index
  begin 
    xml_file = File.open('.\public\shipment.xml', 'rb')
    ShippingController.new(xml_file)
  rescue
    puts "Oops! File Not Found"
  end
end

Index.new
