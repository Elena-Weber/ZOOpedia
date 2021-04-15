class Zookeeper < ActiveRecord::Base

    has_many :animals

    has_secure_password

    validates :zoo, :username, :email, presence: true
    validates :username, uniqueness: true

end