FactoryBot.define do
  factory :user do
    id {1}
    email {"example@example.com"}
    password {"asdfasdf"}
    first_name {"Test"}
    last_name {"Test"}
    role {"Admin"}
  end
end
