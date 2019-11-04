defmodule Regexx.Username do
  def suggest(all_usernames, username, suffix \\ 0) do
    possible_username =
      if suffix > 0 do
        case Regex.named_captures(~r/.*-(?<suffix>.*[0-9])$/, username) do
          nil ->
            case String.match?(username, ~r/.*-$/) do
              false ->
                "#{username}-" <> Integer.to_string(suffix)

              true ->
                Regex.replace(~r/-(?!.*-)/, username, "\\1") <> "-#{suffix}"
            end

          %{"suffix" => previous} ->
            previous_number = previous |> String.to_integer()
            next_number = previous_number + suffix
            Regex.replace(~r/#{previous}(?!.*#{previous})/, username, "\\1") <> "#{next_number}"
        end
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
