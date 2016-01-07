module NeuralNetwork
  class Trainer
    attr_accessor :network, :data

    def initialize(network, data)
      @network = network
      @data = data
    end

    def train(options = {})
      epochs = options[:epochs]
      log_freqs = options[:log_freqs]

      epochs.times do |epoch|
        data.each do |sample|
          network.activate(sample[:input])
          network.train(sample[:output])
          if epoch == 0 || epoch % 1000 == 0
          #if epoch == epochs - 1
            puts "ACTUAL: #{network.activate(sample[:input])}   TARGET: #{sample[:output]}"
          end
        end
      end
    end
  end
end
