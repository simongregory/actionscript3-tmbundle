#!/usr/bin/env ruby -wKU
# encoding: utf-8

require "erb"

# ActionScript 3 snippet builder. Separates the construction of snippets
# from thier representation so the same construction process can create
# different representations.
#
class SnippetBuilder

  private

  def initialize(tp=nil)
    @as3_doc = ENV['TM_ASDOC_GENERATION']
    @t = tp ? tp : SnippetProvider.new
  end

  public

  # =========
  # = ASDoc =
  # =========

  def doc(tag,check_doc=false)

    return "" if check_doc && include_docs == false

    b = binding
    d = File.read(@t.doc)
    t = ERB.new(d)
    t.result b

  end

  def class_doc(check_doc=false)

    return "" if check_doc && include_docs == false

    full_name = ENV['TM_FULLNAME']
    date = `date +%d.%m.%Y`.chop

    b = binding
    d = File.read(@t.class_doc)
    t = ERB.new(d)
    t.result b

  end

  # ===========
  # = Methods =
  # ===========

  def method(name="name",ns="public",doc_tag="private")
    generate_method(name,ns,doc_tag,@t.method)
  end

  def o_method(name="name",ns="public",doc_tag="inheritDoc")
    generate_method(name,ns,doc_tag,@t.o_method)
  end

  def method_handler(name="name",ns="public",doc_tag="private")
    generate_method(name,ns,doc_tag,@t.method_handler)
  end

  def getter(name="name",ns="public",doc_tag="private")
    generate_method(name,ns,doc_tag,@t.get)
  end

  def setter(name="name",ns="public",doc_tag="private")
    generate_method(name,ns,doc_tag,@t.set)
  end

  def i_getter(name="name",ns="public",doc_tag="private")
    generate_method(name,ns,doc_tag,@t.i_get)
  end

  def i_setter(name="name",ns="public",doc_tag="private")
    generate_method(name,ns,doc_tag,@t.i_set)
  end

  def i_method(name="name",ns="public",doc_tag="private")
    generate_method(name,ns,doc_tag,@t.i_method)
  end 
  
  def i_method_handler(name="name",ns="public",doc_tag="private")
    generate_method(name,ns,doc_tag,@t.i_method_handler)
  end

  def var(name="name",ns="public",doc_tag="private")
    if ns == "public"
      generate_method(name,ns,doc_tag,@t.property)
    else
      generate_method(name,ns,doc_tag,@t.var)
    end
  end

  def const(name="name",ns="public",doc_tag="private")
    generate_method(name,ns,doc_tag,@t.const)
  end

  def f_method(name="name",ns="final",doc_tag="private")
    generate_method(name,ns,doc_tag,@t.method)
  end

  # =============================
  # = Package, Interface, Class =
  # =============================

  def class(name="NewClass",ns="public")
    generate_class(name,ns,@t.class)
  end

  def interface(name="NewClass",ns="public")
    generate_class(name,ns,@t.interface)
  end

  def f_class(name="NewClass",ns="final")
    generate_class(name,ns,@t.class)
  end

  private

  def include_docs
    @as3_doc ? true : false
  end

  def generate_method(name,ns,doc_tag,file=nil)

    return "ERROR" unless file

    name = "name" if name.empty?

    asdoc = doc(doc_tag,true)

    b = binding
    d = File.read(file)
    t = ERB.new(d)
    t.result b

  end

  def generate_class(name,ns,file=nil)

    fn = ENV['TM_FILENAME']
    name = File.basename(fn,".as") if fn != nil

    asdoc = class_doc(true)
    doc = doc("constructor",true)

    b = binding
    d = File.read(file)
    t = ERB.new(d)
    t.result b

  end

end

if __FILE__ == $0

  ENV['TM_ASDOC_GENERATION'] = "true"
  ENV['TM_FILENAME'] = "/test/path/to/src/DummyClass.as"

  require 'snippet_provider'

  t = SnippetBuilder.new

  puts t.interface
  puts t.class
  puts t.f_class
  puts t.method
  puts t.method('custom','protected','testing')
  puts t.method_handler
  puts t.o_method
  puts t.getter
  puts t.setter
  puts t.i_getter
  puts t.i_setter
  puts t.i_method
  puts t.i_method_handler
  puts t.var
  puts t.var('private')
  puts t.const
  puts t.f_method

end
