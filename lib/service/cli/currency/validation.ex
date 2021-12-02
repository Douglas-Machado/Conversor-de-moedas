defmodule Service.Currency.Validation do
  @doc """
  Checking if the user input ID is valid
  """
  alias Mix.Shell.IO, as: Shell

  @spec validate(any) :: any
  def validate(map) when map == %{} do
    Shell.prompt("Por favor, digite uma moeda existente!\nPara consultar novamente a lista, pressione Enter")
    Service.CLI.CurrenciesList.coin_list()
  end

  def validate(map) do
    map
  end
end
