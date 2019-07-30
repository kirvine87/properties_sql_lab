require('pg')

class Property

  attr_accessor :value, :buy_let
  attr_reader :id, :address, :number_of_bedrooms


  def initialize(property)
    @id = property['id'].to_i if property['id']
    @address = property['address']
    @value = property['value'].to_i
    @number_of_bedrooms = property['number_of_bedrooms'].to_i
    @buy_let = property['buy_let'] == "t" ? true : false
  end

  def save()
    db = PG.connect({dbname: 'estate_agent', host: 'localhost'})
    sql = "INSERT INTO properties
    (address, value, number_of_bedrooms, buy_let)
    VALUES ($1, $2, $3, $4) RETURNING id"

    values = [@address, @value, @number_of_bedrooms, @buy_let]

    db.prepare("save", sql)

    result = db.exec_prepared("save", values)

    @id = result[0]['id'].to_i()
    db.close()
  end

  def self.delete_all()
    db = PG.connect({dbname: 'estate_agent', host: 'localhost'})

    sql = "DELETE FROM properties"

    db.prepare("delete_all", sql)

    db.exec_prepared("delete_all")
    db.close()
  end

  def delete()
    db = PG.connect({dbname: 'estate_agent', host: 'localhost'})

    sql = "DELETE FROM properties WHERE id = $1"

    values = [@id]

    db.prepare("delete", sql)

    db.exec_prepared("delete", values)

    db.close()

  end

  def update()
    db = PG.connect({dbname: 'estate_agent', host: 'localhost'})

    sql = "UPDATE properties SET
    (address, value, number_of_bedrooms, buy_let) = ($1, $2, $3, $4)
    WHERE id = $5"

    values = [@address, @value, @number_of_bedrooms, @buy_let, @id]

    db.prepare("update", sql)

    db.exec_prepared("update", values)

    db.close()

  end

  def self.find_by_id(id)
    db = PG.connect({dbname: 'estate_agent', host: 'localhost'})

    sql = "SELECT * FROM properties where id = $1"

    values = [id]

    db.prepare("find", sql)

    sale = db.exec_prepared("find", values)
    db.close()

    return Property.new(sale[0])
  end

  def self.find_by_address(address)
    db = PG.connect({dbname: 'estate_agent', host: 'localhost'})

    sql = "SELECT * FROM properties WHERE address = $1"
    values = [address]

    db.prepare("find", sql)

    result = db.exec_prepared("find", values)

    db.close()
    return Property.new(result[0])
  end



end
