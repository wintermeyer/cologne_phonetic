defmodule ColognePhonetic do
  @moduledoc """
  Documentation for `ColognePhonetic`.
  """

  @doc """
  Encode string to cologne phonetics.

  ## Examples

       iex> ColognePhonetic.encode("Elixir")
       "05487"

  """
  def encode(sentence) do
    sentence
    |> String.downcase()
    |> String.split(" ")
    |> Enum.map(&encode_word/1)
    |> Enum.join(" ")
  end

  defp encode_word(word) do
    word
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.map(fn {char, index} -> phonetic_code(char, word, index) end)
    |> Enum.dedup()
    |> Enum.join()
    |> replace_not_leading_zeros()
  end

  defp phonetic_code(char, word, index) do
    prev = get_char_at(word, index - 1)
    next = get_char_at(word, index + 1)
    is_initial = index == 0

    case {char, prev, next, is_initial} do
      {"a", _, _, _} -> "0"
      {"e", _, _, _} -> "0"
      {"i", _, _, _} -> "0"
      {"j", _, _, _} -> "0"
      {"o", _, _, _} -> "0"
      {"u", _, _, _} -> "0"
      {"y", _, _, _} -> "0"
      {"ä", _, _, _} -> "0"
      {"ö", _, _, _} -> "0"
      {"ü", _, _, _} -> "0"
      {"h", _, _, _} -> ""
      {"b", _, _, _} -> "1"
      {"p", _, _, _} when prev not in ["s", "z"] -> "1"
      {"d", _, _, _} when next not in ["c", "s", "z"] -> "2"
      {"t", _, _, _} when next not in ["c", "s", "z"] -> "2"
      {"f", _, _, _} -> "3"
      {"v", _, _, _} -> "3"
      {"w", _, _, _} -> "3"
      {"p", _, _, _} when prev in ["s", "z"] -> "3"
      {"g", _, _, _} -> "4"
      {"k", _, _, _} -> "4"
      {"q", _, _, _} -> "4"
      {"c", _, _, true} when next in ["a", "h", "k", "l", "o", "q", "r", "u", "x"] -> "4"
      {"c", _, _, _} when prev in ["s", "z"] -> "8"
      {"c", _, _, _} when prev in ["c", "k", "q", "x"] -> "8"
      {"c", _, _, _} when next in ["a", "h", "k", "o", "q", "u", "x"] -> "4"
      {"x", _, _, _} when prev not in ["c", "k", "q"] -> "48"
      {"x", _, _, _} when prev in ["c", "k", "q"] -> "8"
      {"l", _, _, _} -> "5"
      {"m", _, _, _} -> "6"
      {"n", _, _, _} -> "6"
      {"r", _, _, _} -> "7"
      {"s", _, _, _} -> "8"
      {"z", _, _, _} -> "8"
      {"ß", _, _, _} -> "8"
      _ -> ""
    end
  end

  defp get_char_at(word, index) do
    if index >= 0 and index < String.length(word) do
      String.at(word, index)
    else
      nil
    end
  end

  defp replace_not_leading_zeros(string) do
    Regex.replace(~r/(?<=\d)0/, string, "")
  end
end
