class Client < ActiveRecord::Base
	attr_accessible :token

	has_many :json_assets
end
