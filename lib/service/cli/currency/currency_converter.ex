defmodule Service.CLI.Currency.CurrencyConverter do
  @doc """
  Receiving the inputs, validating values to the api
  """
  alias Mix.Shell.IO, as: Shell
  alias Service.CLI.Currency.Results

  @spec init :: no_return
  def init do
    input_from = input_formatter((Shell.prompt("Escolha o ID da moeda de origem:")))
    input_to = input_formatter((Shell.prompt("Escolha o ID da moeda de destino:")))
    is_equal(input_from, input_to)
    input_amount = Shell.prompt("Insira a quantidade a ser convertida:")
    amount = parse(input_amount)
    Shell.cmd("clear")

    bid = request(input_from, input_to)
    bid_convert = Float.round(bid["#{input_from}_#{input_to}"] * amount, 2)
    bid_reverse_convert = Float.round(bid["#{input_to}_#{input_from}"] * amount, 2)
    msg = "#{amount} #{input_from} equivale a #{bid_convert} #{input_to}\n#{amount} #{input_to} equivale a #{bid_reverse_convert} #{input_from}"
    Results.result(msg)
  end

  defp parse(value) do
    value = String.replace(value,",",".")
    case Float.parse(value) do
      :error ->
        IO.puts("Insira um valor válido! \n")
        init()
      {number, _} -> is_positive(number)
    end
  end

  defp request(from, to) do
    Currency.Request.get_currency(from, to)
  end

  def input_formatter(input) do
    input = input
    |> String.trim()
    |> String.upcase
    case Integer.parse(input) do
      {_, _} -> IO.gets "Por favor, digite uma moeda existente, pressione qualquer tecla para retornar à seleção"
      Shell.cmd("clear")
      init()
      :error -> input
    end
  end

  defp is_equal(from, to) when from != to, do: to

  defp is_equal(from,to) when from == to do
    Shell.prompt("** Insira duas moedas diferentes **\nPressione qualquer tecla para repetir...")
    Shell.cmd("clear")
    init()
  end

  defp is_positive(number) when number < 0 do
    Shell.prompt "Número inválido, pressione qualquer tecla para tentar novamente..."
    Shell.cmd("clear")
    init()
  end
  defp is_positive(number), do: number
end
