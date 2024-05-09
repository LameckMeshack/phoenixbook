defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _sessions, socket) do
    {:ok,
     assign(socket,
       score: 0,
       secret_number: Enum.random(1..10),
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

  # def handle_event("guess", %{"number" => guess} = data, socket) do
  #   IO.inspect(data)
  #   number = socket.assigns.number

  #   case number == String.to_integer(guess) do
  #     true ->
  #       message = "Your guess: #{guess}. Correct. Guess again. "
  #       score = socket.assigns.score + 1
  #       {:noreply, assign(socket, message: message, score: score, number: Enum.random(1..10))}

  #     false ->
  #       message = "Your guess: #{guess}. Wrong. Guess again. "
  #       score = socket.assigns.score - 1
  #       {:noreply, assign(socket, message: message, score: score)}
  #   end
  # end

  def handle_event("guess", %{"number" => guess} = _data, socket) do
    handle_guess(socket, guess)
  end

  def handle_guess(socket, guess) do
    case Integer.parse(guess) do
      {num, _} when is_integer(num) and num in 1..10 ->
        handle_valid_guess(socket, num)

      _ ->
        handle_invalid_guess(socket)
    end
  end

  defp handle_valid_guess(socket, guess) do
    secret_number = Enum.random(1..10)
    correct_guess = guess == secret_number

    message =
      if correct_guess do
        "Your guess: #{guess}. Correct. Guess again."
      else
        "Your guess: #{guess}. Wrong. Guess again."
      end

    score = update_score(socket.assigns.score, correct_guess)

    {:noreply, assign(socket, message: message, score: score, secret_number: secret_number)}
  end

  defp handle_invalid_guess(socket) do
    message = "Invalid guess. Please enter a number between 1 and 10."
    {:noreply, assign(socket, message: message)}
  end

  defp update_score(score, true), do: score + 1
  defp update_score(score, false), do: score - 1


  def live_patch(socket, _params, _session, socket) do
    {:ok, socket}
  end

  def time do
    DateTime.utc_now() |> to_string
  end
end
