class HomeController < ApplicationController
  require 'util/wether_util'
  before_filter :authenticate_user!

  def index
  end
end
