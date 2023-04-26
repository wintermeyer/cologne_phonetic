defmodule ColognePhoneticTest do
  use ExUnit.Case
  doctest ColognePhonetic

  describe "encode/1" do
    test "encodes words correctly" do
      assert ColognePhonetic.encode("Wikipedia") == "3412"
      assert ColognePhonetic.encode("Müller-Lüdenscheidt") == "65752682"
      assert ColognePhonetic.encode("Erika Mustermann") == "074 682766"
      assert ColognePhonetic.encode("Heinz Classen") == "068 4586"
      assert ColognePhonetic.encode("HeinzClassen") == "068586"
      assert ColognePhonetic.encode("Maier") == "67"
      assert ColognePhonetic.encode("Meier") == "67"
      assert ColognePhonetic.encode("Mayer") == "67"
      assert ColognePhonetic.encode("Mayr") == "67"
      assert ColognePhonetic.encode("Elixir") == "05487"
    end

    test "handles empty string" do
      assert ColognePhonetic.encode("") == ""
    end

    test "handles non-alphabetic characters" do
      assert ColognePhonetic.encode("Elixir!123") == "05487"
    end

    test "handles uppercase characters" do
      assert ColognePhonetic.encode("ELIXIR") == "05487"
    end
  end
end
