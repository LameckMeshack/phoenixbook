defmodule PentoWeb.PageLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "tryry", results: %{})}
  end

  # def render(assigns) do
  #   ~H"""
  #   <div class="container mx-auto">
  #     <h1 class="text-3xl font-bold text-center">Welcome to Pento</h1>
  #     <p class="text-center">This is a simple search page</p>
  #     <div class="mt-4">
  #       <input
  #         type="text"
  #         class="w-full px-4 py-2 border border-gray-300 rounded-md"
  #         phx-debounce="500"
  #         phx-value-search="query"
  #         phx-keyup="search"
  #         placeholder="Search for something..."
  #       />
  #     </div>
  #     <div class="mt-4">
  #       <ul>
  #         <%= for {id, result} <- @results do %>
  #           <li><%= result %></li>
  #         <% end %>
  #       </ul>
  #     </div>
  #   </div>
  #   """
  # end

  def handle_event("search", %{"query" => query}, socket) do
    results = %{1 => "Result 1", 2 => "Result 2", 3 => "Result 3"}
    {:noreply, assign(socket, results: results)}
  end
end
