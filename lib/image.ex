defmodule Identicon.Image do
    @moduledoc """
    Defines data for the image. 
    """

    @doc """
    Defines struct to hold data about image. 
    You can define default value.
    Difference between map and this struct is 
    that here you can specify properties used, only these you can.
    Here we use `hex` representing list of integers, 
    `color` representing RGB color of colored squares in icon, 
    `grid` representing tuples {randomly generated number, 
    index of square} and `pixel_map` to define pixels 
    where squares will be drawn

    ## Examples

        iex> %Identicon.Image{}
        %Identicon.Image{hex: nil}
        iex> %Identicon.Image{[]}
        %Identicon.Image{hex: []}

    """
    defstruct hex: nil, color: nil, grid: nil, pixel_map: nil
end