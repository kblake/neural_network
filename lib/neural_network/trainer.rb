module NeuralNetwork
  class Trainer
    attr_accessor :network, :data

    def initialize(network, data)
      @network  = network
      @data     = data
    end

    def train(options = {})
      epochs    = options[:epochs]
      log_freqs = options[:log_freqs]

      epochs.times do |epoch|
        average_error = data.reduce(0) do |sum, sample|
          network.activate(sample[:input])
          network.train(sample[:output])
          sum + network.error/data.length
        end

        if epoch % log_freqs == 0 || epoch + 1 == epochs
          puts "epoch: #{epoch}  error: #{average_error}"
        end
      end
    end
  end
end
