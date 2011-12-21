module Bushido
  module UserHelper
    def notify(title, body, category)
      Bushido::User.notify(self.ido_id, title, body, "chat")
    end
  end
end
