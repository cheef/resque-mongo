require 'multi_json'

# OkJson won't work because it doesn't serialize symbols
# in the same way yajl and json do.
if MultiJson.engine.to_s == 'MultiJson::Engines::OkJson'
  raise "Please install the yajl-ruby or json gem"
end

module Resque
  # Methods used by various classes in Resque.
  module Helpers
    class DecodeException < StandardError; end

    # Direct access to the Redis instance.
    def mongo
      Resque.mongo
    end

    def mongo_workers
      Resque.mongo_workers
    end

    def mongo_stats
      Resque.mongo_stats
    end

    # Given a Ruby object, returns a string suitable for storage in a
    # queue.
    def encode(object)
      if defined? Yajl
        Yajl::Encoder.encode(object)
      else
        object.to_json
      end
    end

    # Given a string, returns a Ruby object.
    def decode(object)
      return unless object

      if defined? Yajl
        begin
          Yajl::Parser.parse(object, :check_utf8 => false)
        rescue Yajl::ParseError
        end
      else
        begin
          JSON.parse(object)
        rescue JSON::ParserError
        end
      end
    end

    # Given a word with dashes, returns a camel cased version of it.
    #
    # classify('job-name') # => 'JobName'
    def classify(dashed_word)
      dashed_word.split('-').each { |part| part[0] = part[0].chr.upcase }.join
    end

    # Given a camel cased word, returns the constant it represents
    #
    # constantize('JobName') # => JobName
    def constantize(camel_cased_word)
      camel_cased_word = camel_cased_word.to_s

      if camel_cased_word.include?('-')
        camel_cased_word = classify(camel_cased_word)
      end

      names = camel_cased_word.split('::')
      names.shift if names.empty? || names.first.empty?

      constant = Object
      names.each do |name|
        constant = constant.const_get(name) || constant.const_missing(name)
      end
      constant
    end
  end
end
