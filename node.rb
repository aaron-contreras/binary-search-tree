# frozen_string_literal: true

# Represents a node in a Binary Search Tree
class Node
  include Comparable

  attr_reader :value
  attr_accessor :left_child, :right_child

  def initialize(value)
    @value = value
  end

  def <=>(other)
    value <=> other.value
  end
end
