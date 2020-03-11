defmodule Cards do
  @moduledoc """
  Documentation for Cards.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Cards.hello()
      :world

  """
	def create_deck do
		suits = ["S", "C", "H", "D"]
		values = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
	
		# could omit deck = for... and the subsequent return of "deck", loop would impilicityly return
		# but this is how you would assign the return from a for-loop to a variable
		deck = for suit <- suits, value <- values do
			"#{value}-#{suit}"
		end

		deck
	end
	
	def shuffle(deck) do
		Enum.shuffle(deck)
	end

	def contains?(deck, card) do
		
		# Enum.find_value(deck, fn x -> x == card end)
		# ^ Similar achievement to using Enum.member, but return nil instead of false
		Enum.member?(deck, card)
	end

	def deal(deck, num_cards) do
		# will return a Tuple { [hand], [remaining_deck] }
		Enum.split(deck, num_cards)
	end
end
