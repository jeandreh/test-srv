FactoryGirl.define do
  factory :user do
  	name {FFaker::Internet.name}
    email { FFaker::Internet.email }
    password "12345678"
    password_confirmation "12345678"
  end
end
