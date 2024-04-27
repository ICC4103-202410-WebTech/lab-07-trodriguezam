class Post < ApplicationRecord
    belongs_to :user
    belongs_to :parent, class_name: 'Post', optional: true
    has_many :post_tags
    has_many :tags, through: :post_tags
    has_many :answers, class_name: 'Post', foreign_key: :parent_id

    before_create :default_published_at

    validates :title, presence: {
        message: 'Post title required'
    }
    validates :content, presence: {
        message: 'Post content required'
    }
    validates :user_id, presence: {
        message: 'Post user id required'
    }
    validates :answers_count, comparison: {
        greater_than_or_equal_to: 0,
        message: 'Post answers count must be greater than or equal to 0'
    }
    validates :likes_count, comparison: {
        greater_than_or_equal_to: 0,
        message: 'Post likes count must be greater than or equal to 0'
    }

    private

    def default_published_at
        self.published_at ||= Time.now
    end

end