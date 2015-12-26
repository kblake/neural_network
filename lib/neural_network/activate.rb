module NeuralNetwork
  class Activate
    def self.activation_function(input)
      1 / (1+ Math.exp(-input))
    end

    def self.activation_prime(input_val)
      val = 1/(1 + Math.exp(-input_val))
      val * (1 - val)
    end
  end
end
