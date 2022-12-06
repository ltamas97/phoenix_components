defmodule PhoenixComponentsWeb.Modal do
  use Phoenix.LiveComponent
  alias Phoenix.LiveView.JS

  @duration 300

  def show(js \\ %JS{}) do
    js
    |> JS.show(transition: {"ease-out duration-300", "opacity-0", "opacity-100"}, to: "#modal")
    |> JS.show(transition: {"ease-out duration-300", "opacity-0", "opacity-100"}, to: "#black-screen")
  end

  def hide(js \\ %JS{}) do
    js
    |> JS.hide(transition: {"ease-out duration-300", "opacity-100", "opacity-0"}, to: "#modal")
    |> JS.hide(transition: {"ease-out duration-300", "opacity-100", "opacity-0"}, to: "#black-screen")
  end

  def render(assigns) do
    ~H"""
    <div>
      <button phx-click={show()} tabindex="-1" class="rounded-full bg-gray-600 hover:bg-gray-700 active:bg-gray-800 py-1 px-2 text-gray-200">
        Show Modal
      </button>
      <div class="static">
        <div id="modal" class="grid grid-rows-3 p-2 hidden absolute top-1/2 left-1/2 -translate-y-2/4 -translate-x-2/4 w-96 h-96 bg-slate-100 rounded-md shadow-md">
          <span class="block text-right">
            <button phx-click={hide()} class=" text-gray-300 hover:text-gray-400">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                </svg>
            </button>
          </span>
            <h3 class="font-bold">
              Title Of Modal
            </h3>
            <p>
              Lorem ipsum dolor sit amet, consectetur adipiscing elit,
              sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
              Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex
              ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit
              esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat
              non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
            </p>
        </div>
      </div>
    </div>
    """
  end
end
