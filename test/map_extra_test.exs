defmodule MapExtraTest do
  @moduledoc false
  use ExUnit.Case

  import CatchCakeCommon.MapExtra

  doctest CatchCakeCommon.MapExtra

  alias CatchCakeCommon.MapExtra

  test "should raise error if given path don't exists" do
    assert_raise(MapExtra.PathError, fn -> MapExtra.fetch_in!(%{}, [:a, :b, :c]) end)
  end
end
