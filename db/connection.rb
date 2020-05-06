require 'pg'

class Connection
  
  def initialize
    @con = connect_db
  end

  private

  def connect_db
    begin
      PG.connect :dbname => 'shipment', :user => 'postgres', :password => 'root'
    rescue PG::Error => e
      puts e.message 
    end
  end
end
