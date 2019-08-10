
class MyValidator < ActiveModel::Validator
  def validate(comment)

    if comment.message.present?  || comment.rating.present?
      puts "OK" + 'msg:' + comment.message + 'rating:' + comment.rating
      return
      
    end

    if !comment.message.present?
      puts "missing message"
            comment.errors[:message] << 'Please add a message to "Nom" on!' 
    end

    if !comment.rating.present?
      puts "missing rating"
      comment.errors[:rating] << 'Please add at least a rating for us to "Nom" on!' 
      end
  end
end



class Comment < ApplicationRecord
  include ActiveModel::Validations
  validates_with MyValidator


    belongs_to :user
    belongs_to :place

    RATINGS = {
        'One Star': '1_star',
        'Two Stars': '2_stars',
        'Three Stars': '3_stars',
        'Four Stars': '4_stars',
        'Five Stars': '5_stars'
      }

      def humanized_rating
        RATINGS.invert[self.rating]
      end
      
end
