defmodule CatchCakeCommon.ListExtra do
  @moduledoc """
  Extra function that work with the list.
  """

  @doc """
  Add item to list to first postion. `[item | list]` as function.

  ## Examples

    iex> push([1, 2, 3], 10)
    [10, 1, 2, 3]
  """
  @spec push(list(), any()) :: list()
  def push(list, item) when is_list(list) do
    [item | list]
  end

  @doc """
  Merges two lists into one.
  `list1 ++ list2` as function when list1 and list2 is proper list.

  ## Examples

    iex> concat([1, 2], [3, 4])
    [1, 2, 3, 4]
  """
  @spec concat(list(), list()) :: list()
  def concat(l1, l2) when is_list(l1) and is_list(l2) do
    l1 ++ l2
  end
end
