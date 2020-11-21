module API
  module V1
    module Concerns
      module Tokens
        extend ActiveSupport::Concern

        included do
          resource :tokens do
            before do
              @token = Token.find_by_key(params[:token][:key])
            end

            helpers do
              def response(success, message)
                @error = message
                status 400 unless success

                status 204
              end
            end

            desc 'Delete token'
            delete '' do
              response(@token.destroy, 'Error while deleting token')
            end

            desc 'keep alive token'
            patch '/keep_alive' do
              response(@token.update(keep_alive: true), 'Error while aliving token')
            end

            desc 'Release token'
            patch '/release' do
              ReleaseTokenJob.perform_now(@token, true)
              status 201
            end
          end
        end
      end
    end
  end
end
