json.extract! review, :id, :item_id, :user_id, :score, :title, :content, :created_at, :updated_at
json.url review_url(review, format: :json)
