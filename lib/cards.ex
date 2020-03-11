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
	end # create_deck end
	
	def shuffle(deck) do
		Enum.shuffle(deck)
	end # shuffle/1 end

	def contains?(deck, card) do
		
		# Enum.find_value(deck, fn x -> x == card end)
		# ^ Similar achievement to using Enum.member, but return nil instead of false
		Enum.member?(deck, card)
	end # contains/2 end

	def deal(deck, num_cards) do
		# will return a Tuple { [hand], [remaining_deck] }
		Enum.split(deck, num_cards)
	end # deal/2 end

	def save(deck, filename) do
		# Elixir sits on top of Erlang, so Erlang code can be freely called as well
		# Erlang code invoked by using the Atom (constant) :erlang which has many built in methods
		binary = :erlang.term_to_binary(deck)
		File.write(filename, binary)
	end # save/2 end

	def load(filename) do

		# tuple variable assignment
		# { status, binary } = File.read(filename) # will throw argument error if filename doesn't correspond to an existing file
		# catch any errors using a case statement
		# case status do
			# :ok -> :erlang.binary_to_term binary
			# :error -> "Ah, ah, ah. You didn't say the magic word."
		# end

		# above code can be condensed to the following by doing case comparison and variable assignment together
		case File.read(filename) do
			{ :ok, binary } -> :erlang.binary_to_term binary
			# Prepend unused variables with an underscore => the variable name must be there for the sake of pattern matching or an error would be thrown when this case is hit
			{ :error, _err } -> "Ah, ah, ah. You didn't say the magic word."
		end
	end # load/1 end
	
	def create_hand(num_cards) do
		# verbose way of running methods consecutively
		# deck = Cards.create_deck
		# deck = Cards.shuffle(deck)
		# { hand, _remaining_deck } = Cards.deal(deck, num_cards)

		# less verbose code using the pipe operator
		{ hand, _remaining_deck } = 
			Cards.create_deck
			|> Cards.shuffle
			|> Cards.deal(num_cards) # Elixir automatically injects the shuffled deck as the first arg to the deal function

		# return
		hand
	end

end
