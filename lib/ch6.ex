defmodule Ch6 do

  # ch6.1
  def read(file_path) do
    case File.read(file_path) do
      {:ok,bin} -> bin
      {:error,_} -> throw("open file wrong")
    end
  end

  # ch6.2
  def demo3 do
    try do
      generate_exception(5)
    catch
      :error, reason ->
        user_friendly_message = "发生了一个错误，请稍后重试。"
        developer_message = format_developer_message(reason, __STACKTRACE__)
        {user_friendly_message, developer_message}
    end
  end

  defp generate_exception(value) when value > 0 do
    raise "生成异常"  # 抛出一个异常
  end

  defp generate_exception(_) do
    :ok
  end

  defp format_developer_message(reason, stacktrace) do
    "错误类型: #{inspect(reason)}, 堆栈跟踪: #{inspect(stacktrace)}"
  end
end
