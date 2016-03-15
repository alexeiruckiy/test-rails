class AuthorizationController < WebsocketRails::BaseController
  def authorize_channels
    # The channel name will be passed inside the message Hash
    channel = WebsocketRails[message[:document]]
    if can? :subscribe_document, channel
      accept_channel current_user
    else
      deny_channel({:message => 'authorization failed!'})
    end
  end
end