defmodule PhoenixComponentsWeb.PaginationList do
  use Phoenix.LiveComponent

  def mount(socket) do
    socket =
      socket
      |> assign_new(:page, fn -> 0 end)
      |> assign_new(:limit, fn -> 20 end)
      |> assign_new(:data, fn -> [] end)
    {:ok, socket}
  end

  def update(%{page: page} = _params, %{assigns: assigns} = socket) do
    {:ok, data} = assigns.paginator.fetch_data(assigns.limit, page)
    socket =
      socket
      |> assign(:data, data)
      |> assign(:page, page)
    {:ok, socket}
  end

  def update(params, socket) do
    socket =
      if connected?(socket) do
        assigns = socket.assigns
        {:ok, data} = params.paginator.fetch_data(params.limit, assigns.page)
          socket
          |> assign(:data, data)
          |> assign(:id, params.id)
          |> assign(:paginator, params.paginator)
      else
        socket
      end
    {:ok, socket}
  end

  def handle_event("dec", _params, socket) do
    send_update(__MODULE__, %{id: socket.assigns.id, page: clamp(socket.assigns.page - 1)})
    {:noreply, socket}
  end

  def handle_event("inc", _params, socket) do
    if length(socket.assigns.data) == socket.assigns.limit do
      send_update(__MODULE__, %{id: socket.assigns.id, page: socket.assigns.page + 1})
    end
    {:noreply, socket}
  end

  def handle_event(_event , _params, socket) do
    {:noreply, socket}
  end

  defp clamp(page) when page < 0, do: 0
  defp clamp(page), do: page

  def render(assigns) do
    ~H"""
    <div>
      <ul>
        <%= for data <- @data do%>
          <li>
            <%= data %>
          </li>
        <% end %>
      </ul>
    <div>
      <button phx-click="dec" phx-target={@myself}>
        Prev
      </button>
      <span>
        <%= @page + 1 %>
      </span>
      <button phx-click="inc" phx-target={@myself}>
        Nex
      </button>
    </div>
    </div>
    """
  end
end
