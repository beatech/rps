Rps::Application.routes.draw do
  root to: "users#index"
  get  "users" => "users#index"

  post  "users/create"       => "users#create"

  get   "scores" => "scores#index"
  get   "scores/:iidxid"     => "scores#show"
  get   "scores/all/:iidxid" => "scores#show_all"
  post  "scores/update"      => "scores#update"

  get   "powers/update/:iidxid"  => "powers#update"
  get   "powers" => "powers#index"

  get   "musics"             => "musics#index"
  get   "musics/new"         => "musics#new"
  get   "musics/edit/:id"    => "musics#edit"
  get   "musics/:iidxid"     => "musics#diff"
  post  "musics/create"      => "musics#create"
  patch "musics/update"      => "musics#update"
  get   "musics/destroy/:id" => "musics#destroy"
end
