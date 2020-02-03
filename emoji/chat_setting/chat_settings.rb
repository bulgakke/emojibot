require 'json'
require 'telegram/bot'

module Telegram
  module Bot
    module Types
      class Chat
        def load_mode_setting
          parse_settings_json
          return nil unless @@settings[self.id.to_s]
          @emojimode = @@settings[self.id.to_s]
          return @emojimode
        end

        def parse_settings_json
          @json = IO.read('./chat_settings.json')
          @@settings = JSON.parse(@json)
        end

        def emojimode
          return @emojimode if @emojimode
          load_mode_setting
        end

        def update_json
          IO.write('./chat_settings.json', @@settings.to_json)
        end

        def emojimode=(value)
          @emojimode = value
          parse_settings_json
          @@settings.merge!( { self.id => @emojimode } )
          update_json
        end

        def id=(value)
          @id = value
        end
      end
    end
  end
end
