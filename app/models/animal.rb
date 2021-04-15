class Animal < ActiveRecord::Base

    belongs_to :zookeeper

    validates :name, :animal_type, :gender, :age, :likes, presence: true

end