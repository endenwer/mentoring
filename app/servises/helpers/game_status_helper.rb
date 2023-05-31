module GameStatusHelper
  def active_game(user_id)
    Game.find_by(user_id: user_id, status: :active)
  end

  def check_game_availability(chat_id, user_id)
    if active_game(user_id)
      send_message(chat_id, 'You already playing')
      return true
    else
      false
    end
  end
end
