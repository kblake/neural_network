require_relative 'activate'

module NeuralNetwork
  class Neuron
    attr_accessor :input, :outgoing, :output, :incoming, :error, :delta

    # make this a variable in the future
    # to be configurable
    LEARNING_RATE = 0.3

    def initialize
      @incoming = []
      @outgoing = []
    end

    def activate(value = nil)
      return @output = 1 if bias?

      @input = value || incoming.reduce(0) do |sum, connection|
        sum + connection.source.output * connection.weight
      end

      @output = Activate.activation_function(input)
    end

    def connect(target)
      connection = Connection.new(self, target)
      outgoing << connection
      target.incoming << connection
    end

    def train(target_output = nil)
      input_derivative = Activate.activation_prime(@input)

      if output?
        @error = target_output - @output
        @delta = -@error * input_derivative
      else
        @delta = @outgoing.reduce(0) do |sum, connection|
          sum + input_derivative * connection.weight * connection.target.delta
        end
      end

      # update weights - Learning!!
      @outgoing.each do |connection|
        gradient = output * connection.target.delta
        connection.weight -= gradient * LEARNING_RATE
      end
    end

    def bias?
      false
    end

    private

    def output?
      @outgoing.empty?
    end
  end

  class BiasNeuron < Neuron
    def initialize
      @incoming = []
      @outgoing = []
    end

    def bias?
      true
    end
  end
end
