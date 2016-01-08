module NeuralNetwork
  class Neuron
    attr_accessor :input, :outgoing, :output, :incoming, :delta

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

      @output = activation_function(input)
    end

    def connect(target)
      connection = Connection.new(self, target)
      outgoing << connection
      target.incoming << connection
    end

    def input?
      incoming.empty?
    end

    def train(target_output = nil)
      if !bias? && !input?
        if output?
          # this is the derivative of the error function
          # not simply difference in output
          # http://whiteboard.ping.se/MachineLearning/BackProp
          @delta = @output - target_output
        else
          calculate_outgoing_delta
        end
      end

      update_weights
    end

    def bias?
      false
    end

    private

    def output?
      @outgoing.empty?
    end

    def calculate_outgoing_delta
      @delta = @outgoing.reduce(0) do |sum, connection|
        sum + connection.weight * connection.target.delta
      end
    end

    def update_weights
      @outgoing.each do |connection|
        gradient = output * connection.target.delta
        connection.weight -= gradient * LEARNING_RATE
      end
    end

    def activation_function(input)
      1 / (1+ Math.exp(-input))
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
