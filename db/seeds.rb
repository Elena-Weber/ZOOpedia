Zookeeper.destroy_all
Animal.destroy_all

Zookeeper.create(username: "elena", email: "email@email.com", password: "password", zoo: "Chicago Zoo")
Zookeeper.create(username: "greg", email: "email@email.com", password: "password", zoo: "Detroit Zoo")
Zookeeper.create(username: "william", email: "email@email.com", password: "password", zoo: "New York Zoo")
Zookeeper.create(username: "anna", email: "email@email.com", password: "password", zoo: "San Diego Zoo")
Zookeeper.create(username: "steve", email: "email@email.com", password: "password", zoo: "Seattle Zoo")

35.times do
    Animal.create(
    name: Faker::Superhero.name,
    animal_type: Faker::Creature::Animal.name,
    gender: Faker::Gender.binary_type,
    age: rand(1..15),
    likes: Faker::Food.dish,
    zookeeper_id: rand(1..5)
)
end

puts "Success"
