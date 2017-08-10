namespace :init_user do
  task init: :environment do
    init_user
  end

  def init_user
    Role.create(name: 'admin')
  end
end

