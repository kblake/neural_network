module NeuralNetwork
  class Network
    attr_accessor :input_layer, :output_layer, :hidden_layers, :error

    def initialize(layer_sizes)
      @input_layer    = Layer.new(layer_sizes.shift)
      @output_layer   = Layer.new(layer_sizes.pop)
      @hidden_layers  = layer_sizes.map{|layer_size| Layer.new(layer_size)}
      @error          = 0

      connect_layers
    end

    def activate(input_values)
      @input_layer.activate(input_values)
      @hidden_layers.each(&:activate)
      @output_layer.activate
    end

    # all layers in reverse, back propogate!!
    def train(target_outputs)
      @output_layer.train(target_outputs)

      # set the new network error after training
      @error = error_function(target_outputs)

      @hidden_layers.reverse.each(&:train)
      @input_layer.train
    end

    private

    def error_function(target_outputs)
      @output_layer.neurons.each_with_index.reduce(0) do |sum, (neuron, index)|
        sum + 0.5 * (target_outputs[index] - neuron.output) ** 2
      end / @output_layer.neurons.length
    end

    def connect_layers
      layers = [
        [@input_layer],
        @hidden_layers,
        [@output_layer]
      ].flatten

      layers.each_with_index do |layer, index|
        nextIndex = index + 1

        if layers[nextIndex]
          layer.connect(layers[nextIndex])
        end
      end
    end
  end
end
