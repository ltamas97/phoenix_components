defmodule PhoenixComponentsWeb.FakeData.TableItems do

  def fetch_data(amount) do
      0..(amount-1)
      |> Enum.map(&(%{id: &1, name: "John Wick #{&1}", age: 20}))
  end
end
