defmodule Currency.Request do
  @doc """
  Two requests to the api, the first one is for the currencies list, and the second one is for the conversion
  """
  @web "https://api.currconv.com/"
  @countries "api/v7/currencies?apiKey="
  @currencies "api/v7/convert?q="
  @key "c7ccfaaa9e434c52a8dc0d5add2c8504"

  def id do
    url = @web <> @countries <> @key
    HTTPoison.start()
    %{body: body} = HTTPoison.get!(url)
    {:ok, content} = Poison.decode(body, %{keys: :atoms})
    content.results
    |> Map.values
    |> Service.CLI.CurrenciesList.list_sep()
  end

  @spec get_currency(any, any) :: any
  def get_currency(from, to) do
    IO.puts (to)
    IO.puts (from)
    url = @web <> @currencies <> "#{from}_#{to},#{to}_#{from}&compact=ultra&apiKey=" <> @key
    HTTPoison.start()
    %{body: body} = HTTPoison.get!(url)
    Service.Currency.Validation.validate(Poison.decode!(body))
  end
end
