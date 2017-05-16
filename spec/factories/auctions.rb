FactoryGirl.define do
  factory :auction do
    association :user, factory: :user

    sequence(:title) {|n| "#{Faker::Commerce.product_name} #{n}"  }
    details            { Faker::Hipster.paragraph }

    end_date         { 60.days.from_now }
    reserve_price    {rand(100)}
  end

end
