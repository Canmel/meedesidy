class DeviseCustomed::RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    # add custom create logic here
    super do |resource|
      resource.group = params[:user][:group]
    end
  end

  def logout
    redirect_to :users
  end

  def update
    super
  end
end