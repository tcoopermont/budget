class Transaction < ActiveRecord::Base
  attr_accessible :amount, :createdate, :vendor
end
