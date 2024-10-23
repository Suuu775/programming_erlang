defmodule Ch7 do
  # ch7.1
  def reverse_byte(<<>>) do
    <<>>
  end
  def reverse_byte(bin) when is_binary(bin) do
    <<x::binary-size(1),y::binary>> = bin
    reverse_byte(y) <> x
  end

  # ch7.2
  def term_to_binary(term) do
    binary_data = :erlang.term_to_binary(term)
    data_length = byte_size(binary_data)
    length_header = <<data_length::32>>
    <<length_header::binary, binary_data::binary>>
  end

  # ch7.3
  def packet_to_term(packet) do
    <<_header::binary-size(4),rest::binary>> = packet
    :erlang.binary_to_term(rest)
  end

  # ch7.4
  # > Ch7.term_to_binary("hello")
  # <<0, 0, 0, 11, 131, 109, 0, 0, 0, 5, 104, 101, 108, 108, 111>>
  # > Ch7.packet_to_term(<<0, 0, 0, 11, 131, 109, 0, 0, 0, 5, 104, 101, 108, 108, 111>>)
  # "hello"

  # ch7.5
  def reverse_bit(bin) when is_binary(bin) do
    bin
    |>:binary.bin_to_list()
    |>Enum.map(&reverse_bit/1)
    |>:binary.list_to_bin()
  end
end
