class StartService
  include RespondService

  def call(user, from_user)
    return success("Hello, #{user.first_name} #{user.last_name}") if user.present?

    begin
      new_user = User.new(
        telegram_id: from_user['id'],
        first_name: from_user['first_name'],
        last_name: from_user['last_name'],
        username: from_user['username']
      )
      new_user.save!

      success("Profile created, you`r welcome, #{new_user.first_name} #{new_user.last_name}")
    rescue StandardError => e
      failure(e)
    end
  end
end
