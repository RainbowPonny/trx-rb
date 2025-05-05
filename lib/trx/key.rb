# frozen_string_literal: true

module Trx
  class Key
    attr_reader :private_key, :public_key

    def initialize(priv: nil)

      # Creates a new, randomized libsecp256k1 context.
      ctx = Secp256k1::Context.new context_randomization_bytes: SecureRandom.random_bytes(32)

      key = if priv.nil?
              # Creates a new random key pair (public, private).
              ctx.generate_key_pair
            else

              # Converts hex private keys to binary strings.
              priv = Utils.hex_to_bin priv if Utils.is_hex? priv

              # Creates a keypair from existing private key data.
              ctx.key_pair_from_private_key priv
            end

      # Sets the attributes.
      @private_key = key.private_key
      @public_key = key.public_key
    end

    def private_hex
      Utils.bin_to_hex @private_key.data
    end

    def private_bytes
      @private_key.data
    end

    def public_hex
      Utils.bin_to_hex @public_key.uncompressed
    end

    def public_hex_compressed
      Utils.bin_to_hex @public_key.compressed
    end

    def public_bytes
      @public_key.uncompressed
    end

    def public_bytes_compressed
      @public_key.compressed
    end

    def address
      Address.new(address_str(public_hex), private_key: self)
    end

    def address_str(public_hex)
      raise ArgumentError, "Expected String, got #{public_hex.class}" unless public_hex.is_a?(String)

      bytes = Utils.hex_to_bin(public_hex)
      address_bytes = Utils.keccak256(bytes[1..-1])[-20..-1]
      prefixed_address_hex = Trx::Address::ADDRESS_PREFIX + RLP::Utils.encode_hex(address_bytes)
      prefixed_address_bytes = Utils.hex_to_bin(prefixed_address_hex)
      checksum = Utils.base58check(prefixed_address_bytes).hexdigest[0..7]

      Base58.encode_hex(prefixed_address_hex + checksum)
    end

    def sign(blob)
      context = Secp256k1::Context.new
      compact, recovery_id = context.sign_recoverable(@private_key, blob).compact
      signature = compact.bytes
      is_leading_zero = true
      signature.append recovery_id

      # TODO: WTF? It is necessary?

      # [recovery_id].pack("N").unpack("C*").each do |byte|
      #   is_leading_zero = false if byte > 0 and is_leading_zero
      #   unless is_leading_zero and byte === 0
      #     signature.append recovery_id
      #   end
      # end

      Utils.bin_to_hex signature.pack "c*"
    end

    def personal_sign(message)
      prefixed_message = Signature.prefix_message message
      hashed_message = Utils.keccak256 prefixed_message
      sign hashed_message
    end
  end
end
