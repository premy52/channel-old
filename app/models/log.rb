class Log < ActiveRecord::Base
  belongs_to :parent
  belongs_to :banner
  belongs_to :distributor
  belongs_to :dc
  belongs_to :broker
  belongs_to :manager
  belongs_to :store
end
