module NeuralNetwork
  class Neuron
    attr_accessor :input, :outgoing, :output, :incoming

    def initialize
      @incoming = []
      @outgoing = []
    end

    def activation_function(input)
      1 / (1+ Math.exp(-input))
    end

    def activate(value = nil)
      @input = value || incoming.reduce(0) do |sum, connection|
        sum + connection.source.output * connection.weight
      end

      @output = activation_function(input)
    end

    def connect(target)
      connection = Connection.new(self, target)
      outgoing << connection
      target.incoming << connection
    end
  end
end
