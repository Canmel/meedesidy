class Finance < ActiveRecord::Base
  enum log_type: { recharge: 1, refund: 2 }
end
