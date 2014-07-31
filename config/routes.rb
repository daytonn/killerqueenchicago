Rails.application.routes.draw do
  resources :teams
  get "teams/:id/invite", to: "teams#invite", as: "team_invite"
  post "teams/:id/send_invites", to: "teams#send_invites", as: "team_send_invites"

  devise_for :users, :controllers => { :registrations => "registrations" }
  root to: "pages#home"
  get "dashboard", to: "dashboard#index"
end
