# frozen_string_literal: true

require "digest/keccak"
require "rlp"
require "openssl"
require "base58-alphabets"
require "rbsecp256k1"
require "securerandom"
require "faraday"
require "active_support"
require "active_support/core_ext"

require_relative "trx/utils"
require_relative "trx/signature"
require_relative "trx/key"
require_relative "trx/address"
require_relative "trx/version"
require_relative "trx/http_client"
require_relative "trx/abi"
require_relative "trx/abi/function"
require_relative "trx/abi/function_input"
require_relative "trx/abi/function_output"
require_relative "trx/abi/contract_event"

module Trx
  class Error < StandardError; end
end
