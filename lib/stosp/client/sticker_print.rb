# frozen_string_literal: true

module Stosp
  class Client
    module StickerPrint
      def sticker_print(mega_order_ids, options = {})
        get '/org/sticker/apiPrint', options.merge(megaorderIds: mega_order_ids)
      end
    end
  end
end
