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
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end

  @doc """
  Saves image to memory
  """
  def save_image(image, filename) do
    File.write("#{filename}.png", image)
  end

  @doc """
  Draws image, but not saved yet
  """
  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)
    
    Enum.each pixel_map, fn({start, stop}) ->
      :egd.filledRectangle(image, start, stop, fill)
    end

    :egd.render(image)
  end

  @doc """
  Defines pixel map where to draw the squares
  """
  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map = Enum.map grid, fn({_value, index}) ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50

      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}

      {top_left, bottom_right}
    end

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  @doc """
  Removes from grid squares which have odd values, 
  remains just squares with even values
  """
  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid = Enum.filter grid, fn({value, _index}) -> 
      #fn(square) -> {value, _index} = square ...end
      rem(value, 2) == 0
    end

    %Identicon.Image{image | grid: grid}
  end

  @doc """
  Build grid of icon
  """
  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid = 
      hex 
      |> Enum.chunk(3) 
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{image | grid: grid}
  end

  @doc """
  Change one row, to be mirrored
  """
  def mirror_row(row) do
    # <- pound sign
    #[145, 46, 200]
    #[145, 46, 200, 46, 145]
    [first, second | _tail] = row
    row ++ [second, first]
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
