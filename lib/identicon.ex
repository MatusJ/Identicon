defmodule Identicon do
  @moduledoc """
  Generates icon based on user's name. 
  With same name, again and again generates the same icon. 
  """

  @doc """
  Do all functionality to generates icon, based on input string - user's name. 
  """
  def main(input) do
    input 
    |> hash_input
    |> pick_color
  end

  @doc """
  Choose color of squares in icon.
  Based on first 3 values in list of integers.
  """
  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    #def pick_color(image) do
    #%Identicon.Image{hex: hex_list} = image
    #[r, g, b | _tail] = hex_list
    #%Identicon.Image{hex: [r, g, b | _tail]} = image
    #[r, g, b]
    %Identicon.Image{image | color: {r, g, b}}
  end

  @doc """
  Takes input and returns list of integers. 
  """
  def hash_input(input) do
    #array, list of integers
    hex = :crypto.hash(:md5, input) 
    |> :binary.bin_to_list
    #struct holding the hex - list of integers
    %Identicon.Image{hex: hex}
  end
end
