class Post < ApplicationRecord
    validates :title, presence: true
    validates :content, length: { minimum: 250 }
    validates :summary, length: { maximum: 250 }
    validates :category, inclusion: { in: ['Fiction', 'Non-Fiction']}

    #custom Validation

    validate :clickbait?

    #created a class constant to hold all clickbait trends
    #Regex used to see if the trends match with anything placed in title
    #The i after the last forward slash will ignore the case
    #The d will find any digits placed there. This is to determine if we have Top [number]

    CLICKBAIT_TRENDS = [
        /Won't Believe/i,
        /Secret/i,
        /Top \d/i,
        /Guess/i
    ]

    def clickbait?
        if CLICKBAIT_TRENDS.none? { |trend| trend.match title}
            errors.add(:title, "If you want views, then make it clickbait my friend!")
        end
    end
end
