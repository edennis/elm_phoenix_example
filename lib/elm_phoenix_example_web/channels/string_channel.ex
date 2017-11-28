defmodule ElmPhoenixExampleWeb.StringChannel do
  use ElmPhoenixExampleWeb, :channel

  def join("strings", _payload, socket) do
    :timer.sleep(1000)
    {:ok, random_string_msg(), socket}
  end

  defp random_string_msg do
    %{msg: "string" <> to_string(Enum.random(1..100))}
  end
end
