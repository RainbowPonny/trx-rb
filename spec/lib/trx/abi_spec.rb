# frozen_string_literal: true

require "spec_helper"

describe Trx::Abi do
  let!(:abi) do
    [
      {
        "inputs" => [
          {
            "name" => "_greeting",
            "type" => "string"
          }
        ],
        "payable" => false,
        "type" => "constructor"
      },
      {
        "inputs" => [],
        "name" => "getCount",
        "outputs" => [
          {
            "internalType" => "uint256",
            "name" => "count",
            "type" => "uint256"
          }
        ],
        "stateMutability" => "view",
        "type" => "function"
      },
      {
        "inputs" => [],
        "name" => "increment",
        "outputs" => [],
        "stateMutability" => "nonpayable",
        "type" => "function"
      },
      {
        "inputs" => [],
        "name" => "increment",
        "outputs" => [],
        "stateMutability" => "nonpayable",
        "type" => "constructor"
      }
    ]
  end

  it "parses abi" do
    constructor_inputs, functions, = Trx::Abi.parse_abi(abi)

    expect(functions[0].name).to eq "getCount"
    expect(functions[0].outputs[0].type).to eq "uint256"
    expect(constructor_inputs[0].name).to eq "_greeting"
    expect(constructor_inputs[0].type).to eq "string"
  end
end
