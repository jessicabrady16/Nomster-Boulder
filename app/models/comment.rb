# frozen_string_literal: true

class MyValidator < ActiveModel::Validator
  def validate(comment)
    if comment.message.present? || comment.rating.present?
      puts 'OK' + 'msg:' + comment.message + 'rating:' + comment.rating
      return

    end

    unless comment.message.present?
      puts 'missing message'
      comment.errors[:message] << 'Please add a message to "Nom" on!'
    end

    unless comment.rating.present?
      puts 'missing rating'
      comment.errors[:rating] << 'Please add at least a rating for us to "Nom" on!'
      end
  end
end

class Comment < ApplicationRecord
  include ActiveModel::Validations
  validates_with MyValidator

  belongs_to :user
  belongs_to :place
  after_create :send_comment_email

  RATINGS = {
    'One Star': '1_star',
    'Two Stars': '2_stars',
    'Three Stars': '3_stars',
    'Four Stars': '4_stars',
    'Five Stars': '5_stars'
  }.freeze

  def humanized_rating
    RATINGS.invert[rating]
  end

  def send_comment_email
    NotificationMailer.comment_added(self).deliver_now
  end
end
