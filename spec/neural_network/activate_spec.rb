require 'spec_helper'

describe NeuralNetwork::Activate do
  it "#activation_function" do
    expect(described_class.activation_function(1)).to eq 0.7310585786300049
  end

  it "#activation_prime" do
    expect(described_class.activation_prime(1)).to eq 0.19661193324148185
  end
end

