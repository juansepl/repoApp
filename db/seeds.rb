# Create dummy records
100.times do
  Repository.create!(
    id_repo: Faker::Number.unique.number(digits: 7),
    login: Faker::Internet.unique.username(specifier: 10),
    avatar: Faker::Avatar.image(size: '50x50'),
    url: Faker::Internet.unique.url(host: 'github')
  )
end

puts ':::.. Repositories created ..:::'
