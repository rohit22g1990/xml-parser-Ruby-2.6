require 'nokogiri'
require 'open-uri'
require './service/parse_xml_service'

class ParseXml
  
  def initialize(shipping_xml)
    service = ParseXmlService.new
    service.import_xml_to_db(Nokogiri.XML(shipping_xml))
  end

end
