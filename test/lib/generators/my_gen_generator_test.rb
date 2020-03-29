require 'test_helper'
require 'generators/my_gen/my_gen_generator'

class MyGenGeneratorTest < Rails::Generators::TestCase
  tests MyGenGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
