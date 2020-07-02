# frozen_string_literal: true

class Node
  include Comparable

  attr_reader :value
  attr_accessor :left_child, :right_child
  
  def initialize(value)
    @value = value
  end

  def <=>(other_node)
    value <=> other_node.value
  end
end
