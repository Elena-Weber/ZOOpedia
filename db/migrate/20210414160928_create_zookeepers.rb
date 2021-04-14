class CreateZookeepers < ActiveRecord::Migration[5.2]
  def change
    create_table :zookeepers do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :zoo
    end
  end
end
