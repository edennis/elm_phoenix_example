defmodule ElmPhoenixExampleWeb.IntChannel do
  use ElmPhoenixExampleWeb, :channel

  def join("ints", _payload, socket) do
    {:ok, random_int_msg(), socket}
  end

  defp random_int_msg do
    %{msg: Enum.random(1..100)}
  end
end
