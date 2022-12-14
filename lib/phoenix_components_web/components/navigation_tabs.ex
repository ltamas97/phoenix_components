defmodule PhoenixComponentsWeb.NavigationTabs do
  use Phoenix.LiveComponent
  alias Phoenix.LiveView.JS
  def mount(socket) do
    socket =
      socket
      |> assign(:tabs, [])
      |> assign(:active_tab, nil)
    {:ok, socket}
  end

  def update(%{tab: tab} = _params, socket) do
    {:ok, assign(socket,:active_tab, tab)}
  end
  def update(params, socket) do
    socket =
      if connected?(socket) do
        socket
        |> assign(:tabs, params.tabs)
        |> assign(:active_tab, hd(params.tabs))
        |> assign(:id, params.id)
      else
        socket
      end
    {:ok, socket}
  end


  def set_active_tab(js \\ %JS{}, tab, active_tab) do
    js
    |> JS.add_class("phx-active", to: "#navtab-#{tab.name}")
    |> JS.remove_class("phx-active", to: "#navtab-#{active_tab["name"]}")
  end

  def handle_event("set-active-tab", %{"tab" => tab} = _params, socket) do
    send_update(__MODULE__, %{id: socket.assigns.id, tab: tab})
    {:noreply, socket}
  end

  def handle_event(_event, _params, socket) do
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <nav class="border-b border-gray-300">
        <ul class="flex gap-2">
          <%= for tab <- @tabs do %>
            <li id={"navtab-#{tab.name}"} phx-target={@myself} phx-click={JS.push("set-active-tab", value: %{tab: tab}) |> set_active_tab(tab, @active_tab)} class={"cursor-pointer phx-active:bg-gray-50 phx-active:text-gray-600 text-gray-300 hover:bg-gray-300 hover:text-gray-100 rounded-t-md capitalize py-2 px-4"} >
              <%= tab.name %>
            </li>
          <% end %>
        </ul>
      </nav>
      <div id="tab_content" class="h-96 rounded-b-md bg-gray-50">
        <%= @active_tab["inner_content"] %>
      </div>
    </div>
    """
  end
end
