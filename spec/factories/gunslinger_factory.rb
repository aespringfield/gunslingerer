FactoryBot.define do
    factory :gunslinger do
        sequence(:first_name) { |name| Faker::Name.first_name }
        sequence(:last_name) { |name| Faker::Name.last_name }
        email { Faker::Internet.email("#{first_name}.#{last_name}") }
    end
end