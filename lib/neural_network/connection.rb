module NeuralNetwork
  class Connection
    attr_reader :source, :weight

    def initialize(source, target)
      @source = source # neuron
      @target = target # neuron
      @weight = rand
    end

    def to_s
      "Connection: #{@source} #{@target} #{@weight}"
    end
  end
end
