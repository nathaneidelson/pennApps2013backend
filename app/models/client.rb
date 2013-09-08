class Client < ActiveRecord::Base
	attr_accessible :token, :hook_url

	has_many :json_assets

end
