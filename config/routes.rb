Rails.application.routes.draw do
  devise_for :users, controllers: { passwords: "passwords", registrations: "registrations", sessions: 'sessions' }

  root to: 'site#home'

  ## nolog users
  get 'site/faq'
  get 'site/about_us'
  get 'site/strategies'
  get 'site/fund_security'
  get 'site/regulations'

  ## signed in users
  get 'site/index'
  get 'site/contacts'
  post 'site/send_contact_mailer'

  put 'site/confirm_otp'
  get 'site/resend_otp'

  get 'site/preventing'
  get 'site/privacy'
  get 'site/risk'
  get 'site/security'
  get 'site/terms'

  resources :users, only: [:index, :edit, :update, :show] do
    member do
      get 'history'
    end
  end

  get 'transaction/account_history'
  get 'transaction/deposit_index'
  get 'transaction/deposit_new'
  post 'transaction/deposit_create'
  get 'transaction/withdraw_index'
  get 'transaction/withdraw_new'
  post 'transaction/withdraw_create'
  # admin routes
  get 'transaction/authorize_index'
  put 'transaction/authorize_reject/:id', to: 'transaction#authorize_reject', as: 'transaction_authorize_reject'
  get 'transaction/authorize_edit/:id', to: 'transaction#authorize_edit', as: 'transaction_authorize_edit'
  put 'transaction/authorize_approve/:id', to: 'transaction#authorize_approve', as: 'transaction_authorize_approve'
  # sub_admin routes
  get 'transaction/edit_balance'
  put 'transaction/update_balance'

  resources :documents
end
