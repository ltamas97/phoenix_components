defmodule PhoenixComponents.Generics.Paginator do
  @doc """
  Possible implementation for querying data from DB using Ecto
  ```
    offset = limit * page

    query
    ...
    |> Ecto.Query.limit(^limit)
    |> Ecto.Query.offset(^offset)
  ```
  """
  @callback fetch_data(limit :: integer(), current_page_index :: integer()) :: {:ok, list()}

  defmacro __using__(_opts) do
    quote do
      @behaviour PhoenixComponents.Generics.Paginator
    end
  end
end
