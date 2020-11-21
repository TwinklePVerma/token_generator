module API
  module V1
    class Tokens < Grape::API
      include API::V1::Defaults
      include API::V1::Concerns::Tokens

      resource :tokens do
        desc 'Generate token'
        post '', jbuilder: 'token' do
          @token = Token.new({ key: SecureRandom.base36 })
          if @token.save
            status 200
          else
            status 400
            @error = 'Error while creating token'
          end
        end

        after do
          ReleaseTokenJob.set(wait: 60.seconds).perform_later(@token)
          DeleteTokenJob.set(wait: 5.minutes).perform_later(@token)
        end
        desc 'Assign token'
        get '', jbuilder: 'token' do
          @token = Token.active.first
          if @token
            @token.blocked!
          else
            status 404
            @error = 'No token is free'
          end
        end
      end
    end
  end
end
