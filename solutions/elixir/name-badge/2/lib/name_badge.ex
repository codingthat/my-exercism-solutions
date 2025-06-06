defmodule NameBadge do
  def print(nil, name, department) do
    "#{name} - #{String.upcase(if department, do: department, else: "owner")}"
  end
  def print(id, name, department), do: "[#{id}] - #{print(nil, name, department)}"
end
