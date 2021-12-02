defmodule Mix.Tasks.Start do
  @doc """
  This module start the CLI using Mix.Task
  """
  use Mix.Task
  def run(_), do: Currency.CLI.Init.start_currency()
end
