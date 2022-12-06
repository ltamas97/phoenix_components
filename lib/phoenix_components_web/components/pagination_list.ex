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
    <div class="flex flex-col items-center">
      <ul class="bg-gray-50 rounded-lg border border-gray-200 w-full text-gray-900">
        <%= for data <- @data do%>
          <li class="px-6 py-2 border-b border-gray-200 w-full rounded-t-lg">
            <%= data %>
          </li>
        <% end %>
      </ul>
    <div class="flex w-1/6 justify-between text-gray-300">
      <button phx-click="dec" phx-target={@myself} class="hover:text-gray-400">
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
          <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 12h-15m0 0l6.75 6.75M4.5 12l6.75-6.75" />
        </svg>
      </button>
      <span>
        <%= @page + 1 %>
      </span>
      <button phx-click="inc" phx-target={@myself} class="hover:text-gray-400">
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
          <path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12h15m0 0l-6.75-6.75M19.5 12l-6.75 6.75" />
        </svg>
      </button>
    </div>
    </div>
    """
  end
end
