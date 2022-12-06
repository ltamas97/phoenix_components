defmodule PhoenixComponentsWeb.FakeData.Paginator do
  use PhoenixComponents.Generics.Paginator

  @impl true
  def fetch_data(limit, page) do
    data =
      limit*page..500
      |> Enum.map(fn i -> "I'm #{i} data" end)
      |> Enum.take(limit)

    {:ok, data}
  end
end
