# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#create users

20.times do
  User.create(first_name: Faker::Name.first_name,
                last_name: Faker::Name.last_name,
                email: Faker::Internet.email,
                password: '123',
                password_confirmation: '123'
    )
    puts "User created!"
  end

#create auctions

100.times do
  user = User.all.sample
  Auction.create({ title: Faker::Hacker.say_something_smart,
                    details:  Faker::Hipster.paragraph,
                  end_date:Faker::Date.forward,
                  reserve_price: Faker::Number.decimal(2),
                  user_id: user.id
                  })
   puts 'Auction created!'
end


#create bids

Auction.all.each do |a|
  rand(1..10).times do
    user = User.all.sample
    a.bids.create({
      price: Faker::Number.decimal(2),
      user_id:user.id
      })
    end
  end


users_count = User.count
auctions_count = Auction.count
