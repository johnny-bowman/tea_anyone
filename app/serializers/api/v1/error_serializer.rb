class Api::V1::ErrorSerializer
  def self.error_json(error)
    {
      errors: [
        {
          status: 400,
          message: error
        }
      ]
    }
  end
end
