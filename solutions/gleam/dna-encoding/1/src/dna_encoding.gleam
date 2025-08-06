import gleam/list

pub type Nucleotide {
  Adenine
  Cytosine
  Guanine
  Thymine
}

pub fn encode_nucleotide(nucleotide: Nucleotide) -> Int {
  case nucleotide {
    Adenine -> 0b00
    Cytosine -> 0b01
    Guanine -> 0b10
    Thymine -> 0b11
  }
}

pub fn decode_nucleotide(nucleotide: Int) -> Result(Nucleotide, Nil) {
  case nucleotide {
    0b00 -> Ok(Adenine)
    0b01 -> Ok(Cytosine)
    0b10 -> Ok(Guanine)
    0b11 -> Ok(Thymine)
    _ -> Error(Nil)
  }
}

pub fn encode(dna: List(Nucleotide)) -> BitArray {
  dna
  |> list.fold(<<>>, fn(acc, e) {
    <<acc:bits, encode_nucleotide(e):2>>
  })
}

pub fn decode(dna: BitArray) -> Result(List(Nucleotide), Nil) {
  case dna {
    <<curr:2, rest:bits>> -> case decode(<<rest:bits>>) {
      Ok(names) -> case decode_nucleotide(curr) {
        Ok(name) -> Ok([name, ..names])
        _ -> Error(Nil)
      }
      _ -> Error(Nil)
    }
    <<_:1>> -> Error(Nil)
    _ -> Ok([])
  }
}
