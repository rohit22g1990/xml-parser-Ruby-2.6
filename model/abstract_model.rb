require './db/connection'

class AbstractModel < Connection
  
  def create(data)
    sql = "INSERT 
           INTO #{@table_name} (#{ data.keys.map{|k| "#{k}" }.join(", ") })
           VALUES (#{ data.values.map{|v| "'#{v || null}'" }.join(", ") })
           RETURNING id;"   

    result = @con.exec sql
    return result[0]['id'] # last inserted id
  end

end