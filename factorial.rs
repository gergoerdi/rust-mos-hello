#![no_std]

#[no_mangle]
pub extern "C" fn factorial(n: u16) -> u16 {
  match n {
    0 => 1,
    _ => n * factorial(n-1),
  }
}

#[no_mangle]
pub extern "C" fn factorial2(n: u16) -> u16 {
  (1..n+1).fold(1u16, |acc, v| acc * v)
}
