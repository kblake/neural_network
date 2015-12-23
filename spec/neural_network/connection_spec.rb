require 'spec_helper'

describe NeuralNetwork::Connection do
  it "assign neurons to source and target" do
    neuronA = NeuralNetwork::Neuron.new
    neuronB = NeuralNetwork::Neuron.new
    connection = described_class.new(neuronA, neuronB)
    expect(connection.source).to eq neuronA
    expect(connection.target).to eq neuronB
    expect(0..1).to cover(connection.weight)
  end
end
