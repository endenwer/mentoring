module RespondService
  def success(message)
    { message:, error_message: nil, is_success: true }
  end

  def failure(error)
    { message: nil, error_message: error.to_s, is_success: false }
  end
end
