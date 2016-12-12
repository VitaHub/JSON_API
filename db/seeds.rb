if Address.count < 1
  ActiveRecord::Base.transaction do
    Address.create!(
      ip: "192.168.1.#{(1..50).to_a.sample}"
    )
  end
end

if User.count < 1
  ActiveRecord::Base.transaction do
    100.times do
      user = User.create!(login: Faker::Internet.user_name)
      2_000.times do
        address = Address.order("RANDOM()").first
        Post.create!(
          user: user,
          title: Faker::Book.title,
          body: Faker::Hipster.sentence,
          address: address
        )
        address.users << user unless address.users.find_by(id: user.id)
      end
      print " User #{id} with posts created "
    end
  end
end

address_last = Address.create!(ip: "192.168.1.#{(51..250).to_a.sample}")
2.times do 
  Post.create!(
    user: User.first,
    title: Faker::Book.title,
    body: Faker::Hipster.sentence,
    address: address_last
  )
end
address_last.users << User.first
