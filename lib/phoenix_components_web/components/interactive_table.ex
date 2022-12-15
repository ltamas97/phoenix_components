defmodule PhoenixComponentsWeb.InteractiveTable do
  use Phoenix.LiveComponent
  alias Phoenix.LiveView.JS

  def mount(socket) do
    socket =
      socket
      |> assign(:content, [])
      |> assign(:selected_item, nil)
    {:ok, socket}
  end

  def update(%{content: content, id: id} = _params, socket) do
    socket =
      if connected?(socket) do
        socket
        |> assign(:content, content)
        |> assign(:id, id)
      else
        socket
      end
    {:ok, socket}
  end

  def select_row(js \\ %JS{}, row, selected_item) do
    js
    |> remove_highlight(selected_item)
    |> JS.push("select-row", value: %{id: row})
    |> JS.add_class("phx-active", to: "#interactive-item-#{row}")
  end

  def remove_highlight(js, nil), do: js
  def remove_highlight(js, selected_item), do: JS.remove_class(js, "phx-active", to: "#interactive-item-#{selected_item.id}")

  def handle_event("select-row", %{"id" => id} = _params, %{assigns: assigns} = socket) do
    content = assigns.content
    item = Enum.find(content, nil, &(&1.id == id))
    {:noreply, assign(socket, :selected_item, item)}
  end

  def handle_event(_event, _params, socket) do
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="grid grid-cols-2 gap-3">
      <div class="rounded-lg max-h-96 overflow-x-auto relative">
        <table class="w-full table-fixed text-left" id="content-list">
          <thead class="bg-gray-200 uppercase sticky top-0 text-gray-400">
            <tr>
              <th scope="col" class="py-1 px-6">
                ID
              </th>
              <th scope="col" class="py-1 px-6">
                Name
              </th>
            </tr>
          </thead>
          <tbody class="h-96 overflow-y-auto">
            <%= for row <- @content do %>
              <tr id={"interactive-item-#{row.id}"} class="phx-active:bg-slate-200 text-gray-900 hover:bg-gray-100 bg-gray-50 border border-gray-200 cursor-pointer" phx-click={select_row(row.id, @selected_item)}, phx-target={@myself}>
                <td class="py-1 px-6 text-gray-400">
                  <%= row.id %>
                </td>
                <td class="py-2 px-6">
                  <%= row.name %>
                </td>
              </tr>
            <% end %>
          </tbody>
        </table>
      </div>
      <div id="content-details" class="rounded-lg overflow-y-auto overflow-x-auto relative">
        <%= if not is_nil(@selected_item) do %>
          <table id="content-details-table" class="w-full table-fixed text-left">
            <thead class="bg-gray-200 uppercase text-gray-400">
              <tr>
              <th scope="col" class="py-1 px-6">
                  ID
                </th>
                <th scope="col" class="py-1 px-6">
                  Name
                </th>
                <th scope="col" class="py-1 px-6">
                  Age
                </th>
              </tr>
            </thead>
            <tbody>
              <tr class="text-gray-900 bg-gray-50 border border-gray-200">
                <td class="py-1 px-6 text-gray-400">
                  <%= @selected_item.id %>
                </td>
                <td class="py-1 px-6">
                  <%= @selected_item.name %>
                </td>
                <td class="py-1 px-6">
                  <%= @selected_item.age %>
                </td>
              </tr>
            </tbody>
        </table>
        <% end %>
      </div>
    </div>
    """
  end
end
