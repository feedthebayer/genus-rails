class MessagesController < ApplicationController
  def create
    @message = Message.new(user: current_user,
                           messageable: current_organization,
                           body: params[:message][:body])

    unless @message.save
      flash[:error] = "#{@message.errors.full_messages.first}"
    end
    redirect_to current_organization, change: 'messages'
  end

  def update
    # redirect_to current_organization, change: "messages:#{@message.id}"
  end

  def destroy
    @message = Message.find(params[:id])

    unless @message.destroy
      flash[:error] = "#{@message.errors.full_messages.first}"
    end
    redirect_to current_organization, change: 'messages'
  end

  private

  def message_params
    params.require[:message].permit[:body]
  end
end
