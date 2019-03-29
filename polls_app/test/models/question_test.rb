# == Schema Information
#
# Table name: questions
#
#  id      :bigint(8)        not null, primary key
#  poll_id :integer          not null
#  text    :string           not null
#

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
