require 'spec_helper'

describe NeuralNetwork::Layer do
  let(:layer) { described_class.new(2) }

  it "initialize neurons" do
    expect(layer.neurons.size).to eq 2
    expect(layer.neurons.first.class).to eq NeuralNetwork::Neuron
  end

  context "connect layers" do
    let(:input_layer)  { described_class.new(2) }
    let(:output_layer) { described_class.new(2) }

    it "not outgoing or incoming neurons connected" do
      input_layer.neurons.each do |neuron|
        expect(neuron.outgoing.size).to eq 0
        expect(neuron.incoming.size).to eq 0
      end

      output_layer.neurons.each do |neuron|
        expect(neuron.outgoing.size).to eq 0
        expect(neuron.incoming.size).to eq 0
      end
    end

    it "input layer's outgoing neurons are stored" do
      input_layer.connect(output_layer)

      input_layer.neurons.each do |neuron|
        expect(neuron.outgoing.size).to eq 2
        expect(neuron.outgoing.map(&:target)).to eq output_layer.neurons
        expect(neuron.incoming.size).to eq 0
      end
    end

    it "output layer's incoming neurons + bias neuron are stored" do
      input_layer.connect(output_layer)

      output_layer.neurons.each do |neuron|
        expect(neuron.incoming.size).to eq 3
        expect(neuron.incoming.map(&:source)).to eq input_layer.neurons
        expect(neuron.incoming.map(&:source).any?(&:bias?)).to be_truthy
        expect(neuron.outgoing.size).to eq 0
      end
    end
  end

  context "activating a layer" do
    it "when values are nil" do
      layer.activate
      layer.neurons.each do |neuron|
        expect(neuron.output).to eq 0.5
      end
    end

    it "with values" do
      layer.activate([1,2])
      layer.neurons.each do |neuron|
        expect(0.5..1).to cover(neuron.output)
      end
    end
  end
end
