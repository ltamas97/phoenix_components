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
      <button phx-click={show()} tabindex="-1" class="border border-black">
        Show Modal
      </button>
      <div class="static">
        <div id="modal" class="hidden absolute top-1/2 left-1/2 -translate-y-2/4 -translate-x-2/4 w-96 h-96 bg-slate-100 rounded-md shadow-md">
        <button phx-click={hide()} class="text-slate-300">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
              <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>
      </div>
    </div>
    """
  end
end
