defmodule Regexx.Username do
  def suggest(all_usernames, username, suffix \\ 0) do
    possible_username =
      if suffix > 0 do
        "#{username}-" <> Integer.to_string(suffix)
      else
        username
      end

    already_exists =
      all_usernames
      |> Enum.find(fn existing -> existing == possible_username end)

    if already_exists == nil do
      possible_username
    else
      suggest(all_usernames, username, suffix + 1)
    end
  end
end
