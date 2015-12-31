require 'spec_helper'

describe NeuralNetwork::Neuron do
  let(:neuron) { described_class.new }

  it "has defaults" do
    expect(neuron.incoming).to be_empty
    expect(neuron.outgoing).to be_empty
  end

  context "#activate" do
    it "generates proper output" do
      neuron.activate(1)
      expect(neuron.output).to eq 0.7310585786300049
    end

    it "not incoming connections" do
      neuron.activate
      expect(neuron.output).to eq 0.5
    end

    it "with incoming connections" do
      neuronA = described_class.new
      neuronA.output = 2
      neuronB = described_class.new
      neuronB.output = 5
      connection1 = NeuralNetwork::Connection.new(neuronA, nil)
      connection2 = NeuralNetwork::Connection.new(neuronB, nil)
      neuron.incoming = [connection1, connection2]
      neuron.activate
      expect(0.5..1).to cover(neuron.output)
    end
  end

  it "#connect" do
    neuronA = described_class.new
    neuronA.outgoing = [NeuralNetwork::Connection.new(nil,nil)]
    neuronB = described_class.new
    neuronB.incoming = [NeuralNetwork::Connection.new(nil,nil)]

    neuronA.connect(neuronB)
    expect(neuronA.outgoing.length).to eq 2
    expect(neuronB.incoming.length).to eq 2
  end

  context "bias neuron" do
    it "not a bias" do
      expect(neuron).to_not be_bias
    end

    it "create" do
      expect(NeuralNetwork::BiasNeuron.new.bias?).to be_truthy
    end
  end

  context "training" do
    it "error rate should get smaller" do
      neuronA = NeuralNetwork::Neuron.new
      neuronB = NeuralNetwork::Neuron.new

      neuronA.connect(neuronB)

      old_error = 1000

      100.times do |n|
        neuronA.activate(2)
        neuronB.activate

        neuronB.train(1)
        neuronA.train

        expect(neuronB.error < old_error).to be_truthy
      end

    end

  end
end
