defmodule Currency.CLI.Init do
  @doc """
  This module will introduce the user and call the Options module

  Start by typing 'mix start' in the the project's root folder
  """
  alias Mix.Shell.IO, as: Shell
  alias Service.CLI.Options

  def start_currency do
    welcome()
    Options.options()
  end

  defp welcome() do
    Shell.cmd("clear")
    Shell.info(":Bem-Vindo ao Conversor de Moedas:\n")
    Shell.prompt("Pressione qualquer tecla para continuar...")
  end
end
