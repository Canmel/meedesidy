class Menu < ActiveRecord::Base
  has_and_belongs_to_many :roles, :join_table => :roles_menus
end
