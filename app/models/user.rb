class User < ApplicationRecord
    has_many :posts

    validates :name, presence: { 
        message: 'User name required'
    }
    validates :email, presence: { 
        message: 'User email required'
    }, format: {
        with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i,
        message: 'Valid email format => example.optional@something.optional.other'
    }
    validates :password, presence: {
        message: 'User password required'
    }, length: { 
        minimum: 6 ,
        message: 'Minimum password length: 6'
    }
end