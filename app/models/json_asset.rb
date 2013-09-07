class JsonAsset < ActiveRecord::Base
  attr_accessible :name, :content, :client_id

  belongs_to :client
end
