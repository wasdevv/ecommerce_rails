
# Basic rails db:seed for testing the project.

# # IF U WANT MORE USERS/ETC, just change the number.

def generate_random_email
    Faker::Internet.email
end

def generate_random_product(user)
    user.products.create(
        name: Faker::Commerce.product_name,
        quantity: Faker::Number.between(from: 1, to: 100),
        price: Faker::Commerce.price,
        description: Faker::Lorem.sentence,
        created_at: Faker::Date.backward(days: 20),
        updated_at: Faker::Date.backward(days: 20),
    )
end

100.times do
    user = User.create(email: generate_random_email, password: 'projectrails' )

    generate_random_product(user)
end

puts 'Seed completed'