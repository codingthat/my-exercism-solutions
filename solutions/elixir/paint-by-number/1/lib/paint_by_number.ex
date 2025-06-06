defmodule PaintByNumber do
  def palette_bit_size(color_count) do
    fits_in_bits(color_count, 1)
  end

  # not sure why recursion is specifically requested vs. a loop, but OK:
  defp fits_in_bits(color_count, bit_count_to_try) do
    if Integer.pow(2, bit_count_to_try) >= color_count do
      bit_count_to_try
    else
      fits_in_bits(color_count, bit_count_to_try + 1)
    end
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    <<pixel_color_index::size(palette_bit_size(color_count)), picture::bitstring>>
  end

  def get_first_pixel(picture, color_count)
  def get_first_pixel(<<>>, _), do: nil
  def get_first_pixel(picture, color_count) do
    # oddly, I get "cannot find or invoke local palette_bit_size/1 inside a bitstring size specifier. Only macros can be invoked inside a bitstring size specifier and they must be defined before their invocation. Called as: palette_bit_size(color_count)" if I try to combine the next two lines, despite the successful invokation of palette_bit_size within my bitstring size specifier in prepend_pixel
    # is this a bug in Elixir 1.17.3 (the version I'm currently stuck with)?
    size = palette_bit_size(color_count)
    <<value::size(size), _rest::bitstring>> = picture
    value
  end

  def drop_first_pixel(picture, color_count)
  def drop_first_pixel(<<>>, _), do: <<>>
  def drop_first_pixel(picture, color_count) do
    # see note on previous function
    size = palette_bit_size(color_count)
    <<_value::size(size), rest::bitstring>> = picture
    rest
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
