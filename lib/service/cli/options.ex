defmodule Service.CLI.Options do
  @doc """
  Introducing the user to main menu options and waiting for a input number 1 to 4
  """
  alias Mix.Shell.IO, as: Shell

  def options do
    Shell.cmd("clear")
    Shell.info(" 1 | Lista de Moedas")
    Shell.info(" 2 | Realizar conversão")
    Shell.info(" 3 | Histórico de consultas")
    Shell.info(" 4 | Sair")

    Shell.prompt("Escolha uma opção(número)")
    |> parses
    |> path
  end

  @spec parses(binary) :: integer
  def parses(input) do
    case Integer.parse(input) do
      :error -> options()
      {option, _} -> option
    end
  end

  defp path(option) do
    cond do
      option == 1 ->
        Service.CLI.CurrenciesList.coin_list()

      option == 2 ->
        Shell.cmd("clear")
        Service.CLI.Currency.CurrencyConverter.init()

      option == 3 ->
        Service.CLI.HistorySaveAndLoad.history()

      option == 4 ->
        IO.puts("Obrigado por utilizar nosso conversor")
        exit(:normal)

      true ->
        Service.CLI.Options.options()
    end
  end
end
