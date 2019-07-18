class MessagesController < ApplicationController
	def create
		@message = Message.new(message_params)
		@message.is_read = 0
		if @message.save
			flash[:succ] = "Message Created"
			redirect_to '/'
		else
			flash[:notice] = "Error, message not created"
			redirect_to "/contact_me"
		end
	end

	def show
		@msg = Message.find(params[:id])
		@msg.is_read = 1
		@msg.save
	end

	def destroy
	    @message = Message.find(params[:id])
	    @message.destroy
	    flash[:succ] = "Message Deleted"
	    redirect_to "/dashboard/messages"
  	end

  	def make_unread
  		@message = Message.find(params[:id])
  		@message.is_read = 0
  		if @message.save
  			flash[:succ] = "Message marked as unread"
  			redirect_to "/dashboard/messages"
  		else
  			flash[:notice] = "Error, message not marked as unread"
  			redirect_to @message
  		end
  	end

	def message_params
    	params.require(:message).permit(:name, :email, :msg, :is_read)
	end
end
