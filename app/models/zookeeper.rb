class Zookeeper < ActiveRecord::Base
    
    has_many :animals

    has_secure_password

    #validates :username, uniqueness: true
end