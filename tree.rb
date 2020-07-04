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

  def find(value, root = @root)
    return if root.nil?
    return root if root.value == value

    if value < root.value
      find value, root.left_child
    else
      find value, root.right_child
    end
  end

  def level_order_rec(current_node = @root, queue = [], array = [])
    return array if current_node.nil?

    array << current_node.value
    queue << current_node.left_child if current_node.left_child
    queue << current_node.right_child if current_node.right_child

    level_order_rec queue.shift, queue, array
  end

  def level_order_iterative
    array = []
    queue = [@root]

    until queue.empty?
      current_node = queue.shift
      array << current_node.value
      queue << current_node.left_child if current_node.left_child
      queue << current_node.right_child if current_node.right_child
    end

    array
  end

  def inorder(root = @root, array = [])
    return array if root.nil?

    array << root.value
    inorder(root.left_child, array)
    inorder(root.right_child, array)
  end

  def preorder(root = @root, array = [])
    return array if root.nil?

    preorder(root.left_child, array)
    array << root.value
    preorder(root.right_child, array)
  end

  def postorder(root = @root, array = [])
    return array if root.nil?

    postorder(root.left_child, array)
    postorder(root.right_child, array)
    array << root.value
  end

  def height(value)
    value = find(value) unless value.instance_of? Node
    calculate_height value
  end

  def depth(value)
    value = find(value) unless value.instance_of? Node
    calculate_depth value
  end

  def balanced?
    difference_of_subtree_heights(root).between?(-1, 1)
  end

  def rebalance
    @root = build_tree sort(level_order_rec).uniq
  end

  def pretty_print(node = root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│ ' : ' '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? ' ' : '│ '}", true) if node.left_child
  end

  private

  def leaf?(node)
    node.left_child.nil? && node.right_child.nil?
  end

  def one_child?(node)
    node.left_child.nil? && node.right_child || node.left_child && node.right_child.nil?
  end

  def calculate_depth(target, current_node = @root, count = 0)
    return count if target == current_node

    if target.value < current_node.value
      calculate_depth(target, current_node.left_child, count + 1)
    else
      calculate_depth(target, current_node.rigth_child, count + 1)
    end
  end

  def calculate_height(node)
    return -1 if node.nil?

    1 + [calculate_height(node.left_child), calculate_height(node.right_child)].max
  end

  def difference_of_subtree_heights(node)
    height(node.left_child) - height(node.right_child)
  end
end
