# frozen_string_literal: true

require_relative './merge_sort.rb'
require_relative './node.rb'
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

  def insert(value, root = @root)
    if value < root.value
      return root.left_child = Node.new(value) if root.left_child.nil?

      insert value, root.left_child
    elsif value > root.value
      return root.right_child = Node.new(value) if root.right_child.nil?

      insert value, root.right_child
    end

    # duplicate values are not allowed
  end

  def leaf?(node)
    node.left_child.nil? && node.right_child.nil?
  end

  def one_child?(node)
    node.left_child.nil? && node.right_child || node.left_child && node.right_child.nil?
  end

  def delete(value, root = @root)
    if root.value == value
      if one_child?(root)
        @root = root.left_child || root.right_child
      else
        next_biggest = root.right_child
        second_smallest_in_subtree = next_biggest
        second_smallest_in_subtree = second_smallest_in_subtree.left_child while second_smallest_in_subtree.left_child.left_child

        root.value = second_smallest_in_subtree.left_child.value
        second_smallest_in_subtree.left_child = second_smallest_in_subtree.left_child.right_child
      end

    elsif root.left_child && root.left_child.value == value
      if leaf?(root.left_child)
        root.left_child = nil
      elsif one_child?(root.left_child)
        root.left_child = (root.left_child.left_child || root.left_child.right_child)
      else
        next_biggest = root.left_child.right_child
        second_smallest_in_subtree = next_biggest
        second_smallest_in_subtree = second_smallest_in_subtree.left_child while second_smallest_in_subtree.left_child.left_child

        root.left_child.value = second_smallest_in_subtree.left_child.value
        second_smallest_in_subtree.left_child = second_smallest_in_subtree.left_child.right_child
      end

    elsif root.right_child && root.right_child.value == value
      if leaf?(root.right_child)
        root.right_child = nil if leaf?(root.right_child)
      elsif one_child?(root.right_child)
        root.right_child = (root.right_child.left_child || root.right_child.rigth_child)
      else
        next_biggest = root.right_child.right_child
        second_smallest_in_subtree = next_biggest
        second_smallest_in_subtree = second_smallest_in_subtree.left_child while second_smallest_in_subtree.left_child.left_child
        root.right_child.value = second_smallest_in_subtree.left_child.value
        second_smallest_in_subtree.left_child = second_smallest_in_subtree.left_child.right_child
      end

    else
      if value < root.value
        delete value, root.left_child
      else
        delete value, root.right_child
      end
    end
  end

  def find(value, node = root)
    return if node.nil?
    return node if node.value == value

    if value < node.value
      find value, node.left_child
    else
      find value, node.right_child
    end
  end

  def pretty_print(node = root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│ ' : ' '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? ' ' : '│ '}", true) if node.left_child
  end
end
