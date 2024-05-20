namespace :counter_cache do
  desc "Reset counters for followers, followed_users, posts, and comments"
  task reset_counters: :environment do
    User.find_each do |user|
      User.reset_counters(user.id, :posts)
      User.reset_counters(user.id, :comments)
      User.reset_counters(user.id, :followers)
      User.reset_counters(user.id, :followed_users)
    end

    puts "Posts, Comments, Followers, and Followed Users counts are reset"
  end
end
