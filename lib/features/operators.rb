module ChainDb::Features
  module Operators
    # (==)
    EQUAL = 'Eq'.freeze
    # (!=)
    NOT_EQUAL = 'Ne'.freeze
    # (>)
    GREATER_THAN = 'Gt'.freeze
    # (>=)
    GREATER_THAN_OR_EQUAL = 'Ge'.freeze
    # (<)
    LESS_THAN = 'Lt'.freeze
    # (<=)
    LESS_THAN_OR_EQUAL = 'Le'.freeze
    # (for strings and arrays)
    CONTAINS = 'Contains'.freeze
    # (for strings)
    STARTS_WITH = 'StartsWith'.freeze
    # (for strings)
    ENDS_WITH = 'EndsWith'.freeze
  end
end
