defmodule Ch4 do
  # ch4.1
  def area({:rectangle,width,height}) do
    width*height
  end
  def area({:square,side}) do
    side*side
  end
  def area({:circle,radius}) do
    3.1415926*Float.pow(radius,2)
  end
  def area({:triangle,a,b}) do
    0.5*a*b
  end

  # ch4.2
  def my_tuple_to_list({}) do
    []
  end
  def my_tuple_to_list(t) when is_tuple(t)do
    [elem(t,0)|my_tuple_to_list(Tuple.delete_at(t,0))]
  end

  # ch4.3
  def my_time_func(fun) do
    start_time = System.monotonic_time()
    result = fun.()
    end_time = System.monotonic_time()
    execution_time = System.convert_time_unit(end_time - start_time, :native, :microsecond)
    {result, execution_time}
  end

  def my_date_string() do
    DateTime.utc_now()
    |>DateTime.to_string()
  end

  # ch4.5
  def even(x) when is_integer(x) do
    Integer.mod(x,2)==0
  end
  def odd(x) when is_integer(x) do
    not(even(x))
  end

  # ch4.6
  def filter(_,[]) do
    []
  end
  def filter(fun,[x|xs]) do
    if fun.(x)==true do
      [x|filter(fun,xs)]
    else
      filter(fun,xs)
    end
  end

  # ch4.7
  def split_acc([],even,odd)do
    {Enum.reverse(even),Enum.reverse(odd)}
  end
  def split_acc([x|xs],even,odd) do
    if even(x)==true do
      split_acc(xs,[x|even],odd)
    else
      split_acc(xs,even,[x|odd])
    end
  end

  def split_filter(xs) do
    {filter(&(even(&1)),xs),filter(&(odd(&1)),xs)}
  end

  def split(xs) do
    split_acc(xs,[],[])
  end
end
