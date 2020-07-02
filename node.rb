# frozen_string_literal: true

# Represents a node in a Binary Search Tree
class Node
  include Comparable
  attr_accessor :value, :left_child, :right_child

  def initialize(value)
    @value = value
  end

  def <=>(other)
    value <=> other.value
  end

  def to_s
    value.to_s
  end
end
