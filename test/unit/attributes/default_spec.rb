require 'minitest/autorun'
require 'chef/node'
require 'chef/platform'
require 'fauxhai'

describe 'User::Attributes::Default' do
  let(:attr_ns)   { 'razor' }
  let(:ohai_data) { mock_ohai_data }
  let(:dna_data)  { mock_dna_data }
  let(:node)      { new_node(ohai_data, dna_data) }

  it "sets default persist_mode to mongo" do
    node[attr_ns]['persist_mode'].must_equal "mongo"
  end

  it "sets default persist_host to 127.0.0.1" do
    node[attr_ns]['persist_host'].must_equal "127.0.0.1"
  end

  it "sets default persist_port to 27017" do
    node[attr_ns]['persist_port'].must_equal 27017
  end

  it "sets default persist_timeout to 10" do
    node[attr_ns]['persist_timeout'].must_equal 10
  end

  describe "for mongo persist_mode" do

    let(:dna_data) do
      mock_dna_data({ attr_ns => { 'persist_mode' => 'mongo' } })
    end

    it "sets default persist_host to 127.0.0.1" do
      node[attr_ns]['persist_host'].must_equal "127.0.0.1"
    end

    it "sets default persist_port to 27017" do
      node[attr_ns]['persist_port'].must_equal 27017
    end

    it "sets default persist_port to the mongodb port if set" do
      dna_data['mongodb'] = { 'port' => 1234 }

      node[attr_ns]['persist_port'].must_equal 1234
    end

    it "does not set persist_username by default" do
      node[attr_ns]['persist_username'].must_be_nil
    end

    it "does not set persist_password by default" do
      node[attr_ns]['persist_password'].must_be_nil
    end

    it "sets default postgres/local_server attribute to false" do
      node[attr_ns]['postgres']['local_server'].must_equal false
    end

    it "sets default mongo/local_server attribute to true" do
      node[attr_ns]['mongo']['local_server'].must_equal true
    end

    it "[deprecation] does not set mongodb_address by default" do
      node[attr_ns]['mongodb_address'].must_be_nil
    end

    it "[deprecation] sets persist_host to value of mongodb_address if set" do
      dna_data['razor'] = { 'mongodb_address' => "127.0.1.2" }

      node[attr_ns]['persist_host'].must_equal "127.0.1.2"
    end
  end

  describe "for postgres persist_mode" do

    let(:dna_data) do
      mock_dna_data({ attr_ns => { 'persist_mode' => 'postgres' } })
    end

    it "sets default persist_host to 127.0.0.1" do
      node[attr_ns]['persist_host'].must_equal "127.0.0.1"
    end

    it "sets default persist port to 5432" do
      node[attr_ns]['persist_port'].must_equal 5432
    end

    it "sets default persist_port to the postgresql port if set" do
      dna_data['postgresql'] = { 'config' => { 'port' => 8112 } }

      node[attr_ns]['persist_port'].must_equal 8112
    end

    it "sets default persist_username to razor" do
      node[attr_ns]['persist_username'].must_equal "razor"
    end

    it "sets default persist_password to project_razor" do
      node[attr_ns]['persist_password'].must_equal "project_razor"
    end

    it "sets default postgres/local_server attribute to true" do
      node[attr_ns]['postgres']['local_server'].must_equal true
    end

    it "sets default mongo/local_server attribute to false" do
      node[attr_ns]['mongo']['local_server'].must_equal false
    end
  end

  private

  def mock_ohai_data(options = {})
    platform  = options[:platform] || 'chefspec'
    version   = options[:version]
    Mash.new(Fauxhai.mock(:platform => platform, :version => version).data)
  end

  def mock_dna_data(options = {})
    Mash.new(options)
  end

  def new_node(ohai_data, dna_data = {}, attribute_file = "default")
    node = Chef::Node.new
    node.consume_external_attrs(ohai_data, dna_data)
    node.from_file(File.join(File.dirname(__FILE__),
      %W{.. .. .. attributes #{attribute_file}.rb}))
    node
  end
end
