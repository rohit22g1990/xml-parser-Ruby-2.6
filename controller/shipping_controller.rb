require 'nokogiri'
require 'open-uri'
require './model/shipment'
require './model/package'
require './model/activity'

class ShippingController
  
  def initialize(shipping_xml)
    @xml_to_parse = Nokogiri.XML(shipping_xml)
    import_xml_to_db()
  end

  def import_xml_to_db()
    puts "XML parsing is in process....\n\n\n"
    begin 
      # Inserting shipments data into shipments table
      shipment = Shipment.new()
      @shipment_id = shipment.create(prepare_shipments_data)

      # Inserting packages data into shipments table
      package = Package.new()
      @package_id = package.create(prepare_packages_data)
      
      # Inserting packages data into activities table
      activity_model = Activity.new()
      activities = @xml_to_parse.css('Activity')
      activities.css('Activity').each do | activity |
        activity_model.create(prepare_activities_data(activity))
      end
    rescue
      puts "Oops! Somthing went wrong while importing the data"
      return false
    end

    puts "Data successfully imported to the database!!!!\n\n\n"
  end

  private

  def prepare_shipments_data
    {
      'shipper_number'=>@xml_to_parse.css('Shipper ShipperNumber').text, 
      'service'=> {
        "code": @xml_to_parse.css('Service Code').text,
        "description": @xml_to_parse.css('Service Description').text 
      }.to_json,
      'reference_number'=> {
        "code": @xml_to_parse.css('ReferenceNumber Code').text,
        "value": @xml_to_parse.css('ReferenceNumber Value').text
      }.to_json,
      'identification_number' => @xml_to_parse.css('ShipmentIdentificationNumber').text,
      'pickup_date' => @xml_to_parse.css('PickupDate').text,
      'delivery_date_unavailable' => {
        'type': @xml_to_parse.css('DeliveryDateUnavailable Type').text,
        'description': @xml_to_parse.css('DeliveryDateUnavailable Description').text,
      }.to_json,
      'shipper_address' => {
        'address_line_1': @xml_to_parse.css('Shipper AddressLine1').text,
        'city': @xml_to_parse.css('Shipper City').text,
        'state': @xml_to_parse.css('Shipper StateProvinceCode').text,
        'postal_code': @xml_to_parse.css('Shipper PostalCode').text,
        'country_code': @xml_to_parse.css('Shipper CountryCode').text
      }.to_json,
      'ship_to_address' => {
        'city': @xml_to_parse.css('ShipTo City').text,
        'state': @xml_to_parse.css('ShipTo StateProvinceCode').text,
        'postal_code': @xml_to_parse.css('ShipTo PostalCode').text,
        'country_code': @xml_to_parse.css('ShipTo CountryCode').text
      }.to_json
    }
  end

  def prepare_packages_data
    {
      'shipment_id' => @shipment_id,
      'tracking_number'=> @xml_to_parse.css('Package TrackingNumber').text,
      'package_weight' => @xml_to_parse.css('Package Weight').text,
      'unit_of_measurement' => @xml_to_parse.css('Package UnitOfMeasurement Code').text,
    }
  end

  
  def prepare_activities_data(activity)
    {
      'package_id' => @package_id,
      'city'=> activity.css('ActivityLocation City').text,
      'state' => activity.css('ActivityLocation StateProvinceCode').text,
      'postal_code' => activity.css('ActivityLocation PostalCode').text,
      'country_code' => activity.css('ActivityLocation CountryCode').text,
      'location_code' => activity.css('Code').text,
      'location_description' => activity.css('Description').text,
      'status_type_code' => activity.css('Status StatusType Code').text,
      'status_type_description' => activity.css('Status StatusType Description').text, 
      'status_code' => activity.css('StatusCode Code').text,
      'activity_date' => activity.css('Date').text,
      'activity_time' => activity.css('Time').text
    }
  end
end
