# -*- coding: utf-8 -*-
module Bushido
  class MailController < ApplicationController

    # POST /bushido/mail
    def index
      hook_data = {}
      hook_data[:category]     = "mail"
      hook_data[:event]        = "received"
      hook_data[:data]         = {}
      hook_data[:data][:mail]  = {}

      mailgun_params = [
        "recipient",
        "sender",
        "from",
        "subject",
        "body-plain",
        "stripped-text",
        "stripped-signature",
        "body-html",
        "stripped-html",
        "attachment-count",
        "timestamp",
        "token",
        "signature"]

      mailgun_params.each do |m|
        hook_data[:data][:mail][m] = params[m]
      end
                                                    
      Bushido::Data.fire(hook_data, "mail.received")
      render :text => "ok", :status => 200
    end
  end
end
