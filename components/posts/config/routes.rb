Rails.application.routes.draw do
  resources :posts do
    resources :comments, commentable_type: 'post'
  end
end