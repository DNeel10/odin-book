namespace :comments do
  desc 'Backfill commentable_type and update commentable_id for existing comments'
  task backfill: :environment do
    Comment.find_each do |comment|
      comment.update(
        commentable_type: 'Post',
        commentable_id: comment.post_id
      )
    end
  end
end