defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    @default_message "stack underflow occurred"
    defexception message: @default_message

    @impl true
    def exception([]), do: %StackUnderflowError{}
    def exception(term), do: %StackUnderflowError{
      message: "#{@default_message}, context: #{term}"
    }
  end

  @spec divide([number()]) :: float()
  def divide(list) when length(list) < 2, do: raise(StackUnderflowError, "when dividing")
  def divide([0, _numerator]), do: raise DivisionByZeroError
  def divide([denominator, numerator]), do: numerator / denominator
end
