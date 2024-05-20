namespace :counter_cache do
  desc "Reset Likes count for all Posts and Comments"
  task reset_likes_count: :environment do
    Post.find_each do |post|
      Post.reset_counters(post.id, :likes)
    end

    Comment.find_each do |comment|
      Comment.reset_counters(comment.id, :likes)
    end

    puts "Likes have been reset"
  end
end
