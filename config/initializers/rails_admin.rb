RailsAdmin.config do |config|
  config.main_app_name = ["DJ TAKE AWAY INTERNATIONAL"]
    config.authenticate_with do
      warden.authenticate! scope: :user
    end
    config.current_user_method(&:current_user)

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model Event do
    edit do
      field :name
      field :venue
      field :address
      field :special_guest
      field :ticket_price
      field :start_time
      field :end_time
      field :sold_count do
        read_only true
      end
      field :images do
        partial "my_awesome_partial"
      end
      field :ticket_image, :carrierwave
      field :poster_image, :carrierwave
    end
  end
end
