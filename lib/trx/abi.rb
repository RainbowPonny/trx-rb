module Trx
  module Abi
    extend self

    def parse_abi(abi)
      constructor = abi.detect {|x| x["type"].downcase == "constructor"}
      if constructor.present?
        constructor_inputs = constructor["inputs"].map { |input| FunctionInput.new(input) }
      else
        constructor_inputs = []
      end
      functions = abi.select {|x| x["type"].downcase == "function" }.map { |fun| Function.new(fun) }
      events = abi.select {|x| x["type"].downcase == "event" }.map { |evt| ContractEvent.new(evt) }
      [constructor_inputs, functions, events]
    end

    def parse_type(type)
      raise NotImplementedError if type.ends_with?("]")
      match = /(\D+)(\d.*)?/.match(type)
      [match[1], match[2]]
    end

    def parse_array_type(type)
      match = /(.+)\[(\d*)\]\z/.match(type)
      if match
        [true, match[2].present? ? match[2].to_i : nil, match[1]]
      else
        [false, nil, nil]
      end
    end

  end
end
