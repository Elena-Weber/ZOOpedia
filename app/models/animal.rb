class Animal < ActiveRecord::Base
    
    belongs_to :zookeeper

    #validates :name, :animal_type, :gender, :zookeeper_id, presense: true

end