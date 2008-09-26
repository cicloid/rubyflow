Factory.sequence :title do |n|
  "Some Title #{n}"
end

Factory.sequence :name do |n|
  "name-#{n}"
end

Factory.sequence :login do |n|
  "login#{n}"
end

Factory.sequence :email do |n|
  "user#{n}@example.com"
end