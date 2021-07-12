defmodule MapExtraTest do
  @moduledoc false
  use ExUnit.Case

  alias CatchCakeCommon.MapExtra
  import CatchCakeCommon.MapExtra

  doctest CatchCakeCommon.MapExtra

  test "should raise error if given path don't exists" do
    assert_raise(MapExtra.PathError, fn -> MapExtra.fetch_in!(%{}, [:a, :b, :c]) end)
  end

  test "update_in/3 - should raise error if given path don't exists" do
    assert_raise(KeyError, fn -> MapExtra.update_in(%{}, [:a, :b, :c], fn x -> x + 1 end) end)
  end
end
