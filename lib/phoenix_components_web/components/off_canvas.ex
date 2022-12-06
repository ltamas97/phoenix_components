defmodule PhoenixComponentsWeb.OffCanvas do
  use Phoenix.LiveComponent
  alias Phoenix.LiveView.JS

  @duration 300

  def mount(socket) do
    {:ok, assign(socket, :counter, 0)}
  end

  def show_canvas(js \\ %JS{}) do
    js
    |> JS.show(transition: {"ease-out duration-300", "translate-x-1/4", "translate-x-0"}, to: "#off-canvas")
    |> JS.show(transition: {"ease-out duration-300", "opacity-0", "opacity-100"}, to: "#black-screen")
  end

  def hide_canvas(js \\ %JS{}) do
    js
    |> JS.hide(transition: {"ease-out duration-300", "translate-x-0", "translate-x-96"}, to: "#off-canvas")
    |> JS.hide(transition: {"ease-out duration-300", "opacity-100", "opacity-0"}, to: "#black-screen")
  end

  def handle_event("inc", _params, socket) do
    {:noreply, assign(socket, :counter, socket.assigns.counter + 1)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <button phx-click={show_canvas()} tabindex="-1" class="rounded-full bg-gray-600 hover:bg-gray-700 active:bg-gray-800 py-1 px-2 text-gray-200">
        Show Off Canvas
      </button>
      <div class="static">
        <div id="off-canvas" class="hidden absolute inset-y-0 right-0 w-1/4 bg-white shadow-sm p-2">
          <span class="block text-right">
            <button phx-click={hide_canvas()} class="text-gray-300 hover:text-gray-400">
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          </span>
          <button phx-click="inc" phx-target={@myself} class="rounded-full bg-gray-600 hover:bg-gray-700 active:bg-gray-800 py-1 px-2 text-gray-200">
            Modify content
          </button>
          <span>
            <%= @counter %>
          </span>
        </div>
      </div>
    </div>
    """
  end
end
