namespace :dev do
  desc "Users中confirm_atから１週間が経過していれば削除"

  task reset: %w(db:migrate:reset) do
    %w(dev:import_fixture).each do |task|
      Rake::Task[task].invoke
    end
  end

  task import_fixture: :environment do 
    users = []
    
    # User
    puts ">>>>> create users >>>>>"
    8.times do |i|
      p users << FactoryBot.create(:user, email: "dummy#{i}@example.com")
    end

    # FavoriteUser
    puts ">>>>> create FavoriteUser >>>>>"
    (1...users.count).each do |i|
      p users[i-1].favorite_relations.create!(to_user: users[i])
      p users[i-1].reverse_favorite_relations.create!(from_user: users[i])
    end

    # BoardPost
    puts ">>>>> create BoardPost >>>>>"
    users.each do |user|
      FactoryBot.create(:board_post, user: user, purpose: rand(1..4))
    end

    # Message
    puts ">>>>> create messages >>>>>"
    (1...users.count).each do |i|
      p users[i-1].send_messages.create!(to_user: users[i], content: "こんにちは #{i}")
      p users[i-1].receive_messages.create!(from_user: users[i], content: "こんばんは #{i}")
    end

    # History
    puts ">>>>> create histories >>>>>"
    (1...users.count).each do |i|
      p users[i-1].went_histories.create!(to_user: users[i])
      p users[i-1].came_histories.create!(from_user: users[i])
    end
  end
end
