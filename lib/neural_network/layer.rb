module NeuralNetwork
  class Layer
    attr_accessor :neurons

    def initialize(size)
      @neurons = Array.new(size) { Neuron.new }
    end

    def activate(values = nil)
      values = Array(values) # coerce it to an array if nil

      @neurons.each_with_index do |neuron, index|
        neuron.activate(values[index])
      end
    end

    def connect(target_layer)
      @neurons.each do |source_neuron|
        target_layer.neurons.each do |target_neuron|
          source_neuron.connect(target_neuron)
        end
      end
    end
  end
end
