module NeuralNetwork
  class Network
    attr_accessor :input_layer, :output_layer, :hidden_layers

    def initialize(sizes)
      @input_layer    = Layer.new(sizes.shift)
      @output_layer   = Layer.new(sizes.pop)
      @hidden_layers  = sizes.map{|s| Layer.new(s)}

      connect_layers
    end


    def activate(inputValues)
      @input_layer.activate(inputValues)
      @hidden_layers.each {|hidden_layer| hidden_layer.activate }
      @output_layer.activate
    end

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
