# frozen_string_literal: true

require_relative './merge_sort.rb'
require_relative './node.rb'
require 'pry'
# Represents a Binary Search Tree
class Tree
  include MergeSort

  attr_reader :root
  def initialize(array)
    @root = build_tree(sort(array).uniq)
  end

  def build_tree(array)
    return if array.empty?

    midpoint = array.length / 2

    root = Node.new array[midpoint]
    root.left_child = build_tree array[0...midpoint]
    root.right_child = build_tree array[(midpoint + 1)..-1]

    root
  end

  def pretty_print(node = root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│ ' : ' '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? ' ' : '│ '}", true) if node.left_child
  end
end
