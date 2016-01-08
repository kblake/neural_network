#!/usr/bin/env ruby

require_relative '../lib/neural_network'
require_relative '../lib/neural_network/trainer'
require_relative '../lib/neural_network/data_factory'

network = NeuralNetwork::Network.new([2,1])
trainer = NeuralNetwork::Trainer.new(network, NeuralNetwork::DataFactory::OR_GATE)
trainer.train({epochs: 10000, log_freqs: 1000})
