Rps::Application.routes.draw do
  root to: "users#index"

  post "users/create"   => "users#create",  as: :create_user

  get  "scores/:iidxid" => "scores#show",   as: :show_scores
  post "scores/update"  => "scores#update", as: :scores_update

  get  "powers/update/:iidxid"  => "powers#update", as: :update_powers

  get  "musics"         => "musics#index",  as: :musics
end
