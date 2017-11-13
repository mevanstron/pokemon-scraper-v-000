class Pokemon
  attr_accessor :id, :name, :type, :db, :hp

  def initialize(pokemon, :hp = 60)
    @id = pokemon[:id]
    @name = pokemon[:name]
    @type = pokemon[:type]
    @hp = pokemon[:hp]
    @db = pokemon[:db]
    self.alter_hp(hp)
  end

  def self.save(pk_name, pk_type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", pk_name, pk_type)
  end

  def self.find(id, db)
    results = db.execute("SELECT * FROM pokemon WHERE id = ?", id).first

    pokemon = {:id => results[0], :name => results[1], :type => results[2], :db => db}
    Pokemon.new(pokemon, 60)
  end

  def alter_hp(hp)
    db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", hp, self.id)
  end
end
