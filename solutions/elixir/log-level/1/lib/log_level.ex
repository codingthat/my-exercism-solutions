defmodule LogLevel do
  def to_label(level, legacy?) do
    cond do
      legacy? and (level < 1 or level > 4) -> :unknown
      level == 0 -> :trace
      level == 1 -> :debug
      level == 2 -> :info
      level == 3 -> :warning
      level == 4 -> :error
      level == 5 -> :fatal
      true -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    label = to_label(level, legacy?)
    cond do
      label == :error or label == :fatal -> :ops
      label == :unknown -> cond do
        legacy? -> :dev1
        true -> :dev2
      end
      true -> false
    end
  end
end