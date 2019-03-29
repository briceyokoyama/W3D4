# == Schema Information
#
# Table name: responses
#
#  id               :bigint(8)        not null, primary key
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#

class Response < ApplicationRecord
  before_validation :non_author, :respondent_already_answered?
  validates :user_id, :answer_choice_id, presence: true

  belongs_to :answer_choice,
    class_name: :AnswerChoice,
    primary_key: :id,
    foreign_key: :answer_choice_id
  
  belongs_to :respondent,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id

  has_one :question,
    through: :answer_choice,
    source: :question

  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    self.sibling_responses.exists?(user_id: self.user_id)
  end

  def non_author
    if self.question.poll.author.id == self.user_id
      self.errors[:user_id] << "Author can't respond to poll"
    end
  end


end
