class MessagesController < ApplicationController
  def create
    @message = Message.new(user: current_user,
                           messageable: current_organization,
                           body: params[:message][:body])

    unless @message.save
      flash[:error] = "#{@message.errors.full_messages.first}"
    end
    redirect_to :back
  end

  def update
  end

  def destroy
    @message = Message.find(params[:id])

    unless @message.destroy
      flash[:error] = "#{@message.errors.full_messages.first}"
    end
    redirect_to :back
  end

  private

  def message_params
    params.require[:message].permit[:body]
  end
end
