require 'aws-sdk-lex'

module BotSpec
  module AWS
    class LexService
      def self.load(config)
        return LexService.new(config)
      end

      def initialize(config)
        puts "\n\n make new LEX Service with config: " + config.inspect
        if config[:stub_responses]
          @lex_client = Aws::Lex::Client.new(stub_responses: true)
          post_text_stub_data = config[:stub_responses]
          puts "\n\n call stub_responses with: " + config[:stub_responses].inspect
          @lex_client.stub_responses(config[:stub_responses][:operation_to_stub], config[:stub_responses][:stub_data])

        end
        @config = config
        @bot_name = config[:botname]
        @user_id = "botspec-#{SecureRandom.uuid}"
      end

      def lex_client
        puts "\n\n calling lex client: " + @lex_client.inspect
        @lex_client ||= Aws::Lex::Client.new
      end

      def interaction_to_lex_message(message)
        return {
          bot_name: @bot_name,
          bot_alias: "$LATEST",
          user_id: @user_id,
          session_attributes: {
            "String" => "String",
          },
          request_attributes: {
            "String" => "String",
          },
          input_text: message,
        }
      end

      def post_message message, user_id=''
        resp = lex_client.post_text(interaction_to_lex_message(message))
        sleep(1);
        resp
      end
    end
  end
end

