module UserHelper
  def find_user_by_id(update)
    user_id = from_user(update)['id']
    User.find_by!(telegram_id: user_id)
  end

  def from_user(update)
    update['message']['from']
  end
end
