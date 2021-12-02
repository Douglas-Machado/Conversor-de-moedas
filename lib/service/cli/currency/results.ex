defmodule Service.CLI.Currency.Results do
  @doc """
  The result of conversions will be outputed, saved and the user will choose to go back to main menu or leave
  """
  alias Mix.Shell.IO, as: Shell
  alias Service.CLI.HistorySaveAndLoad

  def result(msg) do
    Shell.cmd("clear")
    msg
    |> HistorySaveAndLoad.save
    Shell.info(msg)

    if Shell.yes?("Deseja fazer outra operação?") do
      Service.CLI.Options.options()
    else
      IO.puts("Obrigado por utilizar nosso conversor")
      exit(:normal)
    end
  end
end
