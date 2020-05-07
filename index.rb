require_relative 'parse_xml'

class Index
  begin 
    xml_file = File.open('.\public\shipment.xml', 'rb')
    ParseXml.new(xml_file)
  rescue
    puts "Oops! File Not Found"
  end
end

Index.new
