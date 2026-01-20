///|
fn main {
  let mut n : Int = 0xbeef
  let a : Int = 0x41c64e6d
  let b : Int = 0x3039
  for _ in 0..<10 {
    n = n * a + b
    println(n.to_string(radix=16))
  }
}
