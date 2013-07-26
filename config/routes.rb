Rps::Application.routes.draw do
  root to: "users#index"

  post  "users/create"       => "users#create"

  get   "scores/:iidxid"     => "scores#show"
  get   "scores/all/:iidxid" => "scores#show_all"
  post  "scores/update"      => "scores#update"

  get   "powers/update/:iidxid"  => "powers#update"

  get   "musics"          => "musics#index"
  get   "musics/edit/:id" => "musics#edit"
  get   "musics/:iidxid"  => "musics#diff"
  patch "musics/update"   => "musics#update"
end
