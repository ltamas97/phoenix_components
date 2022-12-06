defmodule PhoenixComponentsWeb.BlackScreen do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
      <div class="static overflow-hidden">
        <div id="black-screen" class="overflow-hidden hidden absolute bg-black/60 inset-0"></div>
      </div>
    """
  end
end
