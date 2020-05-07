require_relative 'connection'

class CreateDb < Connection
 
  def initialize
    super
    sql = File.open('.\db\schema.sql', 'rb') { |file| file.read }
    $result = @con.exec sql
    if $result
      puts "Tables created successfully"
    else
      puts "Something went wrong"
    end
  end
end

CreateDb.new
