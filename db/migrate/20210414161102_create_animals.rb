class CreateAnimals < ActiveRecord::Migration[5.2]
  def change
    create_table :animals do |t|
      t.string :name
      t.string :animal_type
      t.string :gender
      t.integer :age
      t.string :likes
      t.integer :zookeeper_id
    end
  end
end
