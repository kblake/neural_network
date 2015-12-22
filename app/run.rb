#!/usr/bin/env ruby

require_relative '../lib/neural_network'

neuronA = NeuralNetwork::Neuron.new
neuronB = NeuralNetwork::Neuron.new

neuronA.connect(neuronB)

neuronA.activate(10)
puts neuronA.output

neuronB.activate
puts neuronB.output


inputs = [1,1,1]
layer = NeuralNetwork::Layer.new(inputs.size)
puts layer.neurons

layer.activate(inputs)

layer.neurons.each do |n|
  puts "input - #{n.input}, out - #{n.output}"
end


###############################################
input_layer = NeuralNetwork::Layer.new(2)
output_layer = NeuralNetwork::Layer.new(2)

#puts input_layer.neurons.size
#puts output_layer.neurons.size

input_layer.connect(output_layer)

input_layer.activate([1,2])
output_layer.activate

puts
puts "Input layer - outgoing connections"
input_layer.neurons.each do |n|
  puts "in #{n.input}  out #{n.output}"
end

puts
puts "Output layer - incoming connections"
output_layer.neurons.each do |n|
  puts "in #{n.input}  out #{n.output}"
end


#####################################################
puts
puts "*" * 80
puts "NETWORK"
net = NeuralNetwork::Network.new([3,2,1])
net.activate([1,2, 3])

puts "INPUT"
net.input_layer.neurons.each do |n|
  puts "in #{n.input}  out #{n.output}"
end


puts "HIDDEN"
net.hidden_layers.each do |l|
  l.neurons.each do |n|
    puts "in #{n.input}  out #{n.output}"
  end
end

puts "OUTPUT"
net.output_layer.neurons.each do |n|
  puts "in #{n.input}  out #{n.output}"
end
