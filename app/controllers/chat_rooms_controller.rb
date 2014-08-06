class ChatRoomsController < ApplicationController
	skip_before_filter :verify_authenticity_token
	before_filter :cors_preflight_check
	after_filter :cors_set_access_control_headers

	# For all responses in this controller, return the CORS access control headers.
	def cors_set_access_control_headers
		headers['Access-Control-Allow-Origin'] = '*'
		headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
		headers['Access-Control-Max-Age'] = "1728000"
	end

	# If this is a preflight OPTIONS request, then short-circuit the
	# request, return only the necessary headers and return an empty
	# text/plain.

	def cors_preflight_check
		headers['Access-Control-Allow-Origin'] = '*'
		headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
		headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
		headers['Access-Control-Max-Age'] = '1728000'
	end

	def index
		render :index
	end

	def incoming
		ChatRoom.create(:user_id => current_user.id, :message => params[:message])
		render :json => {}
	end

	def output
		@room = ChatRoom.where(["id > ?", params[:last_id]]).order("created_at ASC, id ASC")
		#@user = User.where("id = ?", @room.user_id)
		render :json => @room
	end
end
