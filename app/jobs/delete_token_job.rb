class DeleteTokenJob < ApplicationJob
  queue_as :default

  def perform(token_id)
    token = Token.find_by_id(token_id)
    token.destroy if token&.blocked? && !token&.keep_alive
  end
end
