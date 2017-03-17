require 'rails_helper'
require 'util/qiniu_util'

describe ChangeRecordsController do
  describe 'index' do
    before do
      allow(QiniuUtil).to receive(:upload2qiniu!).and_return(true)
      @car = create :car_420
      create :record, car: @car
      @user = sign_in_as :admin
    end

    it '测试正常返回' do
      get :index
      expect(assigns(:change_records).count).to eq 1
    end
  end
end