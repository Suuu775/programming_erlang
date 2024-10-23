defmodule SimplySocketExamples do
  def nano_get_url() do
    nano_get_url(~c'www.baidu.com')
  end

  def nano_get_url(host) do
    {:ok,socket} = :gen_tcp.connect(host,80,[:binary,{:packet,0}])
    case :gen_tcp.send(socket,"GET / HTTP/1.0\r\n\r\n") do
      :ok -> receive_data(socket,[])
      {:error,reason} -> reason
    end
  end

  def receive_data(_socket,sofar) do
    receive do
      {:tcp, socket,bin} -> receive_data(socket,[bin|sofar])
      {:tcp_closed,_socket} -> :erlang.list_to_binary(Enum.reverse(sofar))
    end
  end
end
