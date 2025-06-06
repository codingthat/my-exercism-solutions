defmodule Newsletter do
  import File, only: [read!: 1, open!: 2, close: 1]

  def read_emails(path), do: path |> read!() |> String.split("\n", trim: true)

  def open_log(path), do: open!(path, [:write])

  def log_sent_email(pid, email), do: IO.puts(pid, email)

  def close_log(pid), do: close(pid)

  def send_newsletter(emails_path, log_path, send_fun) do
    pid = open_log(log_path)
    emails_path
    |> read_emails()
    |> Enum.each(&(send_fun.(&1) == :ok and log_sent_email(pid, &1)))
    close_log(pid)
  end
end
