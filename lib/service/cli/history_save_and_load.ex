defmodule Service.CLI.HistorySaveAndLoad do
  @doc """
  Saving the results to a '.txt' file, and calling the File.read function to get all the results saved in the txt file
  """
  alias Mix.Shell.IO, as: Shell

  def save(msg) do
    date = Date.to_string(Date.utc_today())
    File.write!("#{File.cwd!()}/saved.txt", "\nConsulta: #{date}\n#{msg}\n", [:append])
  end

  def history() do
    Shell.cmd("clear")
    content = File.read!("#{File.cwd!()}/saved.txt")
    IO.puts("#{content}")

    if Shell.yes?("Deseja fazer outra operação?") do
      Service.CLI.Options.options()
    else
      IO.puts("Obrigado por utilizar sistema")
      exit(:normal)
    end
  end
end
