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

    def cancel_subscription(sub)
      {
        data: {
          type: 'subscription',
          id: sub.id,
          message: "Subscription canceled."
        }
      }
    end
  end
end
