module Bushido
  class MailController < ApplicationController

    # POST /bushido/mail
    def index
      logger.debug "#{params.inspect}"

      hook_data = {}
      hook_data[:category] = "mail"
      hook_data[:event]    = "received"

      hook_data[:data] = {
        :mail => {
          :recipent  => params[:recipent],
          :sender    => params[:sender],
          :from      => params[:from],
          :subject   => params[:subject],
          :body      => params["body-mime"]
          :timestamp => params[:timestamp],
          :token     => params[:token],
          :signature => params[:signature]
        }
      }

      Bushido::Data.fire(hook_data, "mail.received")
      render :text => "ok", :status => 200
    end
  end
end
