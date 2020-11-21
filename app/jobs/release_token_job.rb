class ReleaseTokenJob < ApplicationJob
  queue_as :default

  def perform(token_id, release = false)
    token = Token.find_by_id(token_id)
    token.active! if token&.blocked? && (!token&.keep_alive || release)
  end
end
