FactoryGirl.define do
  factory :role do
    status 1
    factory :admin_role do
      desc "超级管理员"
      name "admin"
    end
  end
end