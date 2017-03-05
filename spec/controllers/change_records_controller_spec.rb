require 'rails_helper'
require 'util/qiniu_util'

describe ChangeRecordsController do
  describe 'index' do
    it '测试正常返回', :vcr do
      u = Car.new FactoryGirl.attributes_for :car_420
      u.valid?
      p u.errors
      @user = sign_in_as :admin
      @car = create :car_420
      @record = create :record, car: @car
      p @record
    end


  end


end