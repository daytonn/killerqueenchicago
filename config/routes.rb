Rails.application.routes.draw do
  get "teams/join", to: "teams#join", as: "teams_join"
  resources :teams
  get "teams/:id/accept/:request_id", to: "teams#accept", as: "team_accept"
  get "teams/:id/reject/:request_id", to: "teams#reject", as: "team_reject"
  get "teams/:id/invite", to: "teams#invite", as: "team_invite"
  post "teams/:id/send_invites", to: "teams#send_invites", as: "team_send_invites"
  get "teams/:id/join", to: "teams#join_team", as: "team_join"

  devise_for :users, :controllers => { :registrations => "registrations" }
  root to: "pages#home"
  get "dashboard", to: "dashboard#index"
end
