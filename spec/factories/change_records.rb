FactoryGirl.define do
  factory :change_record do
    status 1
    factory :record do
      total_distance 100
      drive_distance 100
      car_no "浙ACD420"
    end
  end
end