defmodule CatchCakeCommon.Context do
  @moduledoc """
  A context helpers.
  """

  alias CatchCakeCommon.MapExtra

  @type context() :: map()

  @doc """
  Returns a new empty map.

  ## Examples
      iex> Context.new()
      %{}

  """
  @spec new() :: context()
  def new() do
    Map.new()
  end

  @doc """
  Creates a context from an `enumerable`.
  Duplicated keys are removed; the latest one prevails.

  ## Examples

      iex> Context.new([{:b, 1}, {:a, 2}])
      %{a: 2, b: 1}

      iex> Context.new(a: 1, a: 2, a: 3)
      %{a: 3}

  """
  @spec new(Enumerable.t()) :: context()
  def new(enum) do
    Map.new(enum)
  end

  @doc """
  Derives a new field in context from another field (even nested).

  ## Examples
      iex> context = %{a: 1, b: %{c: 2}}
      iex> Context.derive(context, :d, [:b, :c], fn v -> v * 10 end)
      %{a: 1, b: %{c: 2}, d: 20}

      iex> context = %{a: 1, b: %{c: 2}}
      iex> Context.derive(context, :d, [:b, :c])
      %{a: 1, b: %{c: 2}, d: 2}
  """
  @spec derive(context(), Map.key(), [Map.key()], (any() -> any())) :: context()
  def derive(context, key, path, transform \\ &Function.identity/1)
      when is_map(context) and is_list(path) and is_function(transform, 1) do
    Map.put(
      context,
      key,
      context |> MapExtra.fetch_in!(path) |> transform.()
    )
  end

  @doc """
  Puts the given function return value under key in context.

  ## Examples

      iex> Context.put(%{a: 1, b: 2}, :c, fn %{a: a, b: b} -> a + b end)
      %{a: 1, b: 2, c: 3}

      iex> Context.put(%{a: 1, b: 2}, :d, fn _ -> 50 end)
      %{a: 1, b: 2, d: 50}
  """
  @spec put(context(), Map.key(), (context() -> any())) :: context()
  def put(context, key, f) do
    Map.put(context, key, f.(context))
  end

  @doc """
  Updates a key in a nested context structure.

  ## Examples
      iex> context = %{a: %{b: 1}, c: 3, d: 4}
      iex> Context.update_in(context, [:a, :b], fn ctx -> ctx.a.b + ctx.c + ctx.d end)
      %{a: %{b: 8}, c: 3, d: 4}
  """
  @spec update_in(context(), nonempty_list(Map.key()), (context() -> any())) :: context()
  def update_in(context, path, f) do
    MapExtra.update_in(context, path, fn _ -> f.(context) end)
  end
end
