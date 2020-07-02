# frozen_string_literal: true

# Includes methods to perform sorting using the merge sort algorithm
module MergeSort
  def sort(array)
    return array if array.length < 2

    middle = array.length / 2
    left_half = sort array[0...middle]
    right_half = sort array[middle..-1]

    merge left_half, right_half
  end

  private

  def merge(left_half, right_half)
    merged_array = []

    loop do
      break merged_array + right_half if left_half.empty?
      break merged_array + left_half if right_half.empty?

      merged_array << if left_half.first < right_half.first
                        left_half.shift
                      else
                        right_half.shift
                      end
    end
  end
end
