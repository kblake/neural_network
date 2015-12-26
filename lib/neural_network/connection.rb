module NeuralNetwork
  class Connection
    attr_accessor :source, :target, :weight

    def initialize(source, target)
      @source = source # neuron
      @target = target # neuron
      @weight = 0.4 # rand
    end

    def to_s
      "Connection: #{@source} #{@target} #{@weight}"
    end
  end
end
