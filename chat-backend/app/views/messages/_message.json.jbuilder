json.(message, :id, :body)
json.user message.user, partial: 'users/user', as: :user
