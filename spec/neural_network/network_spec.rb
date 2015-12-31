require 'spec_helper'

describe NeuralNetwork::Network do
  context "initialize layer levels" do
    let(:layer_sizes) { [3,2,2,1] }
    let(:input_size)  { layer_sizes.first }
    let(:output_size) { layer_sizes.last }
    let(:hidden_sizes){ layer_sizes.slice(1...layer_sizes.size-1) }

    let(:network)     { described_class.new layer_sizes.dup }

    it "create input layer with neurons + bias neuron" do
      expect(network.input_layer.neurons.size).to eq input_size + 1 # +1 for bias neuron
    end

    it "create output layer" do
      expect(network.output_layer.neurons.size).to eq output_size
    end

    it "create hidden layer(s)" do
      network.hidden_layers.each_with_index do |hidden_layer, index|
        expect(hidden_layer.neurons.size).to eq network.hidden_layers[index].neurons.size
      end
    end
  end
end
