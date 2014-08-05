class ChatRoom < ActiveRecord::Base
	def time
		created_at.strftime('%-d/%-m/%y %H:%M')
	end

	def serializable_hash(options = {})
		json = super.merge(options)
		json[:time] = time
		return json
	end
end