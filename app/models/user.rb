class User < ActiveRecord::Base
  validates :iidxid, :presence => true
  validates :djname, :presence => true
end
