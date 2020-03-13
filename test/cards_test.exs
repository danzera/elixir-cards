defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "basic arithmetic" do
    assert 1 + 1 == 2
	end
	
	test "create_deck makes 52 cards" do
		deck_length = length(Cards.create_deck)
		assert deck_length == 52
	end

	test "shuffling a deck randomizes it" do
		deck = Cards.create_deck
		assert deck != Cards.shuffle(deck) # potentially, but unlikely to fail if shuffled deck happened to be the same as the original deck
	end

	test "shuffle deck and test using refute" do
		deck = Cards.create_deck
		refute deck == Cards.shuffle(deck) # same as the above test, just written differently with 'refute' and == instead of 'assert' and !=
	end

	test "deal method spits out a hand of num_cards in length" do
		deck = Cards.create_deck
		num_cards = 5
		{ hand, _deck } = Cards.deal(deck, num_cards)
		assert length(hand) == num_cards
	end

	test "remainder of deck contains num_cards fewer than a full deck after dealing a hand" do
		deck = Cards.shuffle(Cards.create_deck)
		num_cards = 5
		{ _hand, remaining_deck } = Cards.deal(deck, num_cards)
		assert length(remaining_deck) == length(deck) - num_cards
	end

	test "create hand spits out a hand of num_cards in length" do
		num_cards = 5
		hand = Cards.create_hand(num_cards)
		assert length(hand) == num_cards
	end

	test "saving and loading a deck returns the original data" do
		deck_original = Cards.shuffle(Cards.create_deck)
		filename = "test_file"
		Cards.save(deck_original, filename)
		deck_from_saved_file = Cards.load(filename)
		assert deck_original == deck_from_saved_file
	end

end
