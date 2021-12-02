defmodule Service.CLI.CurrenciesList do
  @doc """
  This module show the main currency options amd display an option to user get all the currencies available and another to go to converter
  """
  alias Mix.Shell.IO, as: Shell

  def coin_list() do
    Shell.cmd("clear")
    Shell.info("BRL - Real")
    Shell.info("USD - Dólar")
    Shell.info("EUR - Euro")
    Shell.info("BTC - Bitcoin")
    Shell.info("JPY - Iene Japonês")
    input = Shell.prompt("\nPara mais opções, digite 1 \nPara ir ao conversor, digite 2\n")

    cond do
      input == "2\n" ->
        Service.CLI.Currency.CurrencyConverter.init()

      input == "1\n" ->
        Currency.Request.id

      true ->
        Shell.prompt("Opção inexistente! Tente novamente\n")
        coin_list()
    end
  end

  def list_sep(output) do
    Shell.cmd("clear")
    output
    |> Enum.sort(&(&1.currencyName <= &2.currencyName))
    |> Scribe.print(data: [{"Nome da moeda", :currencyName}, {"Símbolo da moeda", :currencySymbol}, {"ID", :id}])
    Shell.prompt("Pressione qualquer tecla para ir ao conversor")
    Service.CLI.Currency.CurrencyConverter.init()
  end
end
