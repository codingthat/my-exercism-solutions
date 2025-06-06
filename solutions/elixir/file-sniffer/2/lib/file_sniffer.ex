defmodule FileSniffer do
  @types [
    ["exe", "application/octet-stream", <<0x7F, 0x45, 0x4C, 0x46>>],
    ["bmp", "image/bmp", <<0x42, 0x4D>>],
    ["png", "image/png", <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A>>],
    ["jpg", "image/jpg", <<0xFF, 0xD8, 0xFF>>],
    ["gif", "image/gif", <<0x47, 0x49, 0x46>>],
  ]

  Enum.each(@types, fn [ext, type, header] ->
    def type_from_extension(unquote(ext)), do: unquote(type)
    def type_from_binary(unquote(header) <> <<_::binary>>), do: unquote(type)
    def verify(unquote(header) <> <<_::binary>>, unquote(ext)), do: {:ok, unquote(type)}
  end)
  def type_from_extension(_), do: nil
  def type_from_binary(_), do: nil
  def verify(_, _), do: {:error, "Warning, file format and file extension do not match."}

end
