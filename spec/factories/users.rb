FactoryGirl.define do
  factory :user do
    status 1
    factory :user_admin do
      email 'lidejian@skio.cn'
      name '张全蛋'
      password 'lidejian'
      password_confirmation 'lidejian'
    end
  end
end