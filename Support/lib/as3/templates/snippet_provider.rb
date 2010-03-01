#!/usr/bin/env ruby -wKU
# encoding: utf-8

# Data provider for SnippetBuilder. Encapsulates paths to the various
# erb templates.
#
# TODO: This should be refactored to load and return the documents rather
# than the paths.
#
class SnippetProvider

  attr_reader :class
  attr_reader :class_doc
  attr_reader :const
  attr_reader :doc
  attr_reader :get
  attr_reader :interface
  attr_reader :i_get
  attr_reader :i_method
  attr_reader :i_method_handler
  attr_reader :i_set
  attr_reader :method
  attr_reader :method_handler
  attr_reader :namespace
  attr_reader :o_method
  attr_reader :property
  attr_reader :set
  attr_reader :var

  def initialize()

    bp = File.dirname(__FILE__)+'/model/'

    @class            = bp+'class.erb'
    @class_doc        = bp+'class_doc.erb'
    @const            = bp+'const.erb'
    @doc              = bp+'doc.erb'
    @get              = bp+'get.erb'
    @interface        = bp+'interface.erb'
    @i_get            = bp+'i_get.erb'
    @i_method         = bp+'i_method.erb'
    @i_method_handler = bp+'i_method_handler.erb'
    @i_set            = bp+'i_set.erb'
    @method           = bp+'method.erb'
    @method_handler   = bp+'method_handler.erb'
    @namespace        = bp+'namespace.erb'
    @o_method         = bp+'o_method.erb'
    @property         = bp+'property.erb'
    @set              = bp+'set.erb'
    @var              = bp+'var.erb'

  end

end
