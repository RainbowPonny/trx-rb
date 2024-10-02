# frozen_string_literal: true

module Trx
  module Signature
    class SignatureError < StandardError; end
    extend self

    PREFIX_BYTE = "\x19"

    def prefix_message(message)
      "#{PREFIX_BYTE}Tron Signed Message:\n#{message.size}#{message}"
    end
  end
end
