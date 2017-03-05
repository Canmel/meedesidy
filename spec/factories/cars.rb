FactoryGirl.define do
  factory :car do
    status 1
    factory :car_420 do
      car_no '浙ACD420'
      color '白'
      vin 'LJUB1P2W9ES004431'
      status 2
      driver_id 1
    end
  end
end