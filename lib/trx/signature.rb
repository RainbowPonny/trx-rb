# frozen_string_literal: true

module Trx
  module Signature
    class SignatureError < StandardError; end
    extend self

    PREFIX_BYTE = "\x19".freeze

    def prefix_message(message)
      "#{EIP191_PREFIX_BYTE}Tron Signed Message:\n#{message.size}#{message}"
    end
  end
end
