# frozen_string_literal: true

require_relative 'merge_sort.rb'
# Represents a Binary Search Tree
class Tree
  include MergeSort

  def initialize(array)
    @root = build_tree(sort(array).uniq)
  end

  def build_tree(array)
    array
  end
end
