Factory.define(:user) do |u|
  u.sequence(:email) { |n| "email#{n}@example.com" }
  u.name { "John Doe" }
  u.password "password"
  u.password_confirmation "password"
end
