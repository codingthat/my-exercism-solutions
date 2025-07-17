defmodule GottaSnatchEmAll do
  import MapSet
  @type card :: String.t()
  @type collection :: MapSet.t(card())

  @spec new_collection(card()) :: collection()
  def new_collection(card), do: new([card])

  @spec add_card(card(), collection()) :: {boolean(), collection()}
  def add_card(card, collection) do
    {member?(collection, card), put(collection, card)}
  end

  @spec trade_card(card(), card(), collection()) :: {boolean(), collection()}
  def trade_card(your_card, their_card, collection) do
    {
      not member?(collection, their_card) and member?(collection, your_card),
      collection |> delete(your_card) |> put(their_card)
    }
  end

  @spec remove_duplicates([card()]) :: [card()]
  def remove_duplicates(cards), do: Enum.sort(new(cards))

  @spec extra_cards(collection(), collection()) :: non_neg_integer()
  def extra_cards(your_collection, their_collection) do
    difference(your_collection, their_collection)
    |> size()
  end

  @spec boring_cards([collection()]) :: [card()]
  def boring_cards([]), do: []
  def boring_cards([collection]), do: Enum.sort(collection)
  def boring_cards([a, b | t]), do: boring_cards([intersection(a, b) | t])


  @spec total_cards([collection()]) :: non_neg_integer()
  def total_cards([]), do: 0
  def total_cards([collection]), do: size(collection)
  def total_cards([a, b | t]), do: total_cards([union(a, b) | t])

  @spec split_shiny_cards(collection()) :: {[card()], [card()]}
  def split_shiny_cards(collection) do
    {a, b} = split_with(collection, &String.starts_with?(&1, "Shiny"))
    {to_list(a), to_list(b)}
  end
end
