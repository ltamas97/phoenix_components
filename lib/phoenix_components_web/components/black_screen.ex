defmodule PhoenixComponentsWeb.BlackScreen do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
      <div class="static">
        <div id="black-screen" class="hidden absolute bg-black/60 inset-0"></div>
      </div>
    """
  end
end
