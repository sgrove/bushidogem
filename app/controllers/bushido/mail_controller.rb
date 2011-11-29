# -*- coding: utf-8 -*-
module Bushido
  class MailController < ApplicationController

    # POST /bushido/mail
    def index
      mail = {}
      attachments = []

      # Strip the attachments first
      params.keys.each do |key|
        attachments << params.delete(key) if key =~ /attachment-\d+/
      end

      # Copy the params to the hook data
      (params.keys - ["controller", "action"]).each do |param|
        mail[param.downcase] = params[param]
      end

      mail["attachments"] = attachments

      # Mailroute is in charge of figuring out which callback to trigger
      Bushido::Mailroute.routes.process(mail)
      render :text => "ok", :status => 200
    end
  end
end
