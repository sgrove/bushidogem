# -*- coding: utf-8 -*-
module Bushido
  class MailController < ApplicationController

    # POST /bushido/mail
    def index
      hook_data             = {}

      attachments = []

      # Strip the attachments first
      params.keys.each do |key|
        attachments << params.delete(key) if key =~ /attachment-\d+/
      end

      # Copy the params to the hook data
      (params.keys - ["controller", "action"]).each do |param|
        hook_data[param.downcase] = params[param]
      end

      hook_data["attachments"] = attachments

      Bushido::Data.fire(hook_data, "mail.received")
      render :text => "ok", :status => 200
    end
  end
end
