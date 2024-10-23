defmodule Ch16 do
  # ch16.1
  def recompile(file_path) do
    dir_name = :filename.dirname(file_path)
    beam_name = file_path
    |> :filename.basename(".ex")
    |>String.capitalize()
    beam_name = "Elixir.#{beam_name}.beam"
    beam_name = dir_name <> "/#{beam_name}"
    if :calendar.datetime_to_gregorian_seconds(get_mtime(file_path))>:calendar.datetime_to_gregorian_seconds(get_mtime(beam_name)) do
      IO.puts("need recompile")
    else
      IO.puts("don't need recompile")
    end
  end

  defp get_mtime(file_name) do
    case File.stat(file_name) do
      {:ok,fs} -> fs|>Map.get(:mtime)
      {:error,_} -> exit("file can't read")
    end
  end

  # ch16.2
  def compute_file_md5(file_path) do
    case File.read(file_path) do
      {:ok,bin} -> :erlang.md5(bin)
      {:error,_} -> exit("file can't read")
    end
  end

  # ch16.3
  def compute_big_file_md5(file_path) do
    case File.read(file_path) do
      {:ok,bin} -> bin
        |>:erlang.binary_to_list()
        |>Enum.chunk_every(50)
        |>Enum.reduce(:erlang.md5_init,&(:erlang.md5_update(&2,&1)))
        |>:erlang.md5_final()
      {:error,_} -> exit("file can't read")
    end
  end
end
