# frozen_string_literal: true

module Trx
  class Address
    ADDRESS_PREFIX = "41"

    def self.from_public_hex(public_hex)
      bytes = Utils.hex_to_bin(public_hex)
      address_bytes = Utils.keccak256(bytes[1..-1])[-20..-1]
      prefixed_address_hex = ADDRESS_PREFIX + RLP::Utils.encode_hex(address_bytes)
      prefixed_address_bytes = Utils.hex_to_bin(prefixed_address_hex)
      checksum = Utils.base58check(prefixed_address_bytes).hexdigest[0..7]
      base58check_adress = Base58.encode_hex(prefixed_address_hex + checksum)

      Address.new(base58check_adress)
    end

    attr_reader :address

    def initialize(address)
      @address = Utils.prefix_hex(address)
    end

    def checksum_matches?
      computed_checksum = Utils.sha256(
        Utils.sha256(to_bytes[0..-5]).digest
      ).hexdigest[0..7]

      checksum_hex == computed_checksum
    end
    alias_method :valid?, :checksum_matches?

    def to_bytes
      Utils.hex_to_bin(to_hex)
    end

    def to_hex
      Utils.base58_decode_hex(address)
    end

    def to_s
      Utils.remove_hex_prefix(address)
    end

    private

    def checksum_bytes
      bytes[0..3]
    end

    def checksum_hex
      to_hex[-8..-1]
    end
  end
end
