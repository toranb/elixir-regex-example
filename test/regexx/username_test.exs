defmodule Regexx.UsernameTest do
  use ExUnit.Case, async: false

  alias Regexx.Username

  @username "foobarbaz"

  test "returns original username when all usernames is empty list" do
    possible_username =
      []
      |> Username.suggest(@username)

    assert possible_username == @username
  end

  test "returns alternative when username found in all usernames list" do
    possible_username =
      [@username]
      |> Username.suggest(@username)

    assert possible_username == "#{@username}-1"
  end

  test "returns alternative when username duplicated in all usernames list" do
    possible_username =
      [@username, @username]
      |> Username.suggest(@username)

    assert possible_username == "#{@username}-1"
  end

  test "returns alternative when both first and second options are taken" do
    possible_username =
      ["zipzapzoom", @username, "#{@username}-1"]
      |> Username.suggest(@username)

    assert possible_username == "#{@username}-2"
  end

  test "returns alternative username when original ends with numeric suffix" do
    possible_username =
      ["zipzapzoom", "#{@username}-1"]
      |> Username.suggest("#{@username}-1")

    assert possible_username == "#{@username}-2"
  end

  test "returns alternative username when original ends with large numeric suffix" do
    possible_username =
      ["zipzapzoom", "#{@username}-122"]
      |> Username.suggest("#{@username}-122")

    assert possible_username == "#{@username}-123"
  end

  test "returns alternative username when original ends with numeric suffix and first option is taken" do
    possible_username =
      ["zipzapzoom", "#{@username}-122", "#{@username}-123"]
      |> Username.suggest("#{@username}-122")

    assert possible_username == "#{@username}-124"
  end
end
