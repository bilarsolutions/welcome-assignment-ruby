class MessagesController < ApplicationController
  # GET /messages
  def index
    @messages = Message.all

    render json: @messages
  end

  # POST /messages
  def create

logger.fatal "----------------"

    @message = Message.new(message_params)
    @message.user = current_user

    if @message.save
      ActionCable.server.broadcast("messages", @message.as_json(methods: [ :name ]))
      render status: :created, content_type: 'application/json; charset=utf-8'
    else
      render json: { errors: @message.errors }, status: :unprocessable_entity
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:body)
    end
end
