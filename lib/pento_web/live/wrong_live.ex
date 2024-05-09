defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _sessions, socket) do
    {:ok,
     assign(socket,
       score: 0,
       number: Enum.random(1..10),
       message: "Guess a number."
     )}
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>

    <h2>
      <%= @message %> It's <%= time() %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number={n}><%= n %></a>
      <% end %>
    </h2>
    """
  end

  def handle_event("guess", %{"number" => guess} = data, socket) do
    IO.inspect(data)
    number = socket.assigns.number

    case number == String.to_integer(guess) do
      true ->
        message = "Your guess: #{guess}. Correct. Guess again. "
        score = socket.assigns.score + 1
        {:noreply, assign(socket, message: message, score: score, number: Enum.random(1..10))}

      false ->
        message = "Your guess: #{guess}. Wrong. Guess again. "
        score = socket.assigns.score - 1
        {:noreply, assign(socket, message: message, score: score)}
    end
  end

  def time do
    DateTime.utc_now() |> to_string
  end
end
