# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

def generate_random_email
    Faker::Internet.email
end

def generate_random_product(user)
    user.products.create(
        name: Faker::Commerce.product_name,
        quantity: Faker::Number.between(from: 1, to: 100),
        price: Faker::Commerce.price,
        description: Faker::Lorem.sentence
    )
end

10.times do
    user = User.create(email: generate_random_email, password: 'projectrails' )

    generate_random_product(user)
end

puts 'Seed completed'