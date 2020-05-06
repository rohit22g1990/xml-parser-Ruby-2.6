require_relative 'connection'

class CreateDb < Connection
 
  def initialize
    super
    sql = File.open('.\db\schema.sql', 'rb') { |file| file.read }
    @con.exec sql
  end
end

CreateDb.new
