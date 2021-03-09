# frozen_string_literal: true

require_relative 'tools/array'
require_relative 'tools/hash'
require_relative 'validator'

require 'pry'

class DataParser
  # type = :count (default) -> just count in groups
  # type = :uniq -> uniq entries in groups
  def initialize(container)
    @container = container
  end

  def execute(type)
    @container.result =
      @container.data
                .group_by_index(0)
                .count_by_groups(type)
                .to_a
                .sort_by { |item| item[1] }
                .reverse
                .map { |i| i.map(&:to_s).join(' ') }
    self
  end
end
