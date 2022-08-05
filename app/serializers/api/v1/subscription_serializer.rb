class Api::V1::SubscriptionSerializer
  class << self
    def create_subscription(sub, tea_titles)
      {
        data: {
          type: 'subscription',
          id: sub.id,
          attributes: {
            status: sub.status,
            frequency: sub.frequency,
            price: sub.price,
            teas: tea_titles
          }
        }
      }
    end

    def invalid_email
      {
        errors: [
          {
            status: 401,
            message: 'invalid email'
          }
        ]
      }
    end

    def invalid_tea_title
      {
        errors: [
          {
            status: 400,
            message: "one or more of your requested tea titles don't exist - check for typos!"
          }
        ]
      }
    end
  end
end
