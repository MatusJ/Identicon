defmodule Identicon.Image do
    @moduledoc """
    Defines data for the image. 
    """

    @doc """
    Defines struct to hold data about image. 
    Default value is nil. 
    Difference between map and this struct is thath here you can specify only `hex:` property. 

    ## Examples

        iex> %Identicon.Image{}
        %Identicon.Image{hex: nil}
        iex> %Identicon.Image{[]}
        %Identicon.Image{hex: []}

    """
    defstruct hex: nil
end