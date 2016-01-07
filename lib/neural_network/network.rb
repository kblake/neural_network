module NeuralNetwork
  class Network
    attr_accessor :input_layer, :output_layer, :hidden_layers

    def initialize(layer_sizes)
      @input_layer    = Layer.new(layer_sizes.shift)
      @output_layer   = Layer.new(layer_sizes.pop)
      @hidden_layers  = layer_sizes.map{|layer_size| Layer.new(layer_size)}

      connect_layers
    end

    def activate(input_values)
      @input_layer.activate(input_values)
      @hidden_layers.each(&:activate)
      @output_layer.activate
    end

    def train(target_outputs)
      # all layers in reverse, back propogate!!
      @output_layer.train(target_outputs)
      @hidden_layers.reverse.each(&:train)
      @input_layer.train
    end

    #def errorFn(target_outputs)
      #index = -1
      #output_layer.neurons.reduce(0) do |sum, neuron|
        #index = index + 1
        #sum + 0.5 * (target_outputs[index] ** 2)
      #end
    #end

    private

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
