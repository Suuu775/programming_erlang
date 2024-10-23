defmodule Ch5 do
  # ch5.1
  def read_file(file_path) do
    file_path
    |>File.read!()
    |>Jason.decode()
  end

  # ch5.2
  def map_search_pred(map,pred) when is_map(map) and is_function(pred) do
    map
    |>Stream.filter(pred)
    |>Enum.take(1)
    |>List.first()
  end
end
