// メルセンヌツイスタのテストコード

// 基本シーケンステスト - シード 5489

///|
test "basic_sequence_seed_5489" {
  let mt = MT::make(5489U)

  // 1回目
  assert_eq(mt.get_rand(), 3499211612U)
  // 2回目
  assert_eq(mt.get_rand(), 581869302U)
  // 3回目
  assert_eq(mt.get_rand(), 3890346734U)

  // 10回目まで進める (現在3回呼んでいるので、あと6回)
  for i = 0; i < 6; i = i + 1 {
    mt.get_rand() |> ignore
  }
  // 10回目
  assert_eq(mt.get_rand(), 1323567403U)

  // 100回目まで進める (現在10回呼んでいるので、あと89回)
  for i = 0; i < 89; i = i + 1 {
    mt.get_rand() |> ignore
  }
  // 100回目
  assert_eq(mt.get_rand(), 3468319344U)

  // 623回目まで進める (現在100回呼んでいるので、あと522回)
  for i = 0; i < 522; i = i + 1 {
    mt.get_rand() |> ignore
  }
  // 623回目
  assert_eq(mt.get_rand(), 2227348307U)
  // 624回目
  assert_eq(mt.get_rand(), 4020325887U)
  // 625回目
  assert_eq(mt.get_rand(), 4178893912U)
  // 626回目
  assert_eq(mt.get_rand(), 610818241U)

  // 1000回目まで進める (現在626回呼んでいるので、あと373回)
  for i = 0; i < 373; i = i + 1 {
    mt.get_rand() |> ignore
  }
  // 1000回目
  assert_eq(mt.get_rand(), 1341017984U)
}

// 基本シーケンステスト - シード 0

///|
test "basic_sequence_seed_0" {
  let mt = MT::make(0U)
  assert_eq(mt.get_rand(), 2357136044U)
  assert_eq(mt.get_rand(), 2546248239U)
  assert_eq(mt.get_rand(), 3071714933U)
  for i = 0; i < 6; i = i + 1 {
    mt.get_rand() |> ignore
  }
  assert_eq(mt.get_rand(), 2678185683U)
  for i = 0; i < 89; i = i + 1 {
    mt.get_rand() |> ignore
  }
  assert_eq(mt.get_rand(), 1396067212U)
  for i = 0; i < 522; i = i + 1 {
    mt.get_rand() |> ignore
  }
  assert_eq(mt.get_rand(), 631131020U)
  assert_eq(mt.get_rand(), 3791854820U)
  assert_eq(mt.get_rand(), 341544762U)
  assert_eq(mt.get_rand(), 1076416385U)
  for i = 0; i < 373; i = i + 1 {
    mt.get_rand() |> ignore
  }
  assert_eq(mt.get_rand(), 3043451800U)
}

// 基本シーケンステスト - シード 1

///|
test "basic_sequence_seed_1" {
  let mt = MT::make(1U)
  assert_eq(mt.get_rand(), 1791095845U)
  assert_eq(mt.get_rand(), 4282876139U)
  assert_eq(mt.get_rand(), 3093770124U)
  for i = 0; i < 6; i = i + 1 {
    mt.get_rand() |> ignore
  }
  assert_eq(mt.get_rand(), 1013994432U)
  for i = 0; i < 89; i = i + 1 {
    mt.get_rand() |> ignore
  }
  assert_eq(mt.get_rand(), 2253996187U)
  for i = 0; i < 522; i = i + 1 {
    mt.get_rand() |> ignore
  }
  assert_eq(mt.get_rand(), 3906854836U)
  assert_eq(mt.get_rand(), 2006116153U)
  assert_eq(mt.get_rand(), 1104314680U)
  assert_eq(mt.get_rand(), 939235918U)
  for i = 0; i < 373; i = i + 1 {
    mt.get_rand() |> ignore
  }
  assert_eq(mt.get_rand(), 548926898U)
}

// 基本シーケンステスト - シード 12345

///|
test "basic_sequence_seed_12345" {
  let mt = MT::make(12345U)
  assert_eq(mt.get_rand(), 3992670690U)
  assert_eq(mt.get_rand(), 3823185381U)
  assert_eq(mt.get_rand(), 1358822685U)
  for i = 0; i < 6; i = i + 1 {
    mt.get_rand() |> ignore
  }
  assert_eq(mt.get_rand(), 2285257250U)
  for i = 0; i < 89; i = i + 1 {
    mt.get_rand() |> ignore
  }
  assert_eq(mt.get_rand(), 3922418062U)
  for i = 0; i < 522; i = i + 1 {
    mt.get_rand() |> ignore
  }
  assert_eq(mt.get_rand(), 2929929201U)
  assert_eq(mt.get_rand(), 2940097750U)
  assert_eq(mt.get_rand(), 3957348375U)
  assert_eq(mt.get_rand(), 3514278914U)
  for i = 0; i < 373; i = i + 1 {
    mt.get_rand() |> ignore
  }
  assert_eq(mt.get_rand(), 47030557U)
}

// 基本シーケンステスト - シード 4294967295 (0xFFFFFFFF)

///|
test "basic_sequence_seed_max" {
  let mt = MT::make(4294967295U)
  assert_eq(mt.get_rand(), 419326371U)
  assert_eq(mt.get_rand(), 479346978U)
  assert_eq(mt.get_rand(), 3918654476U)
  for i = 0; i < 6; i = i + 1 {
    mt.get_rand() |> ignore
  }
  assert_eq(mt.get_rand(), 1217888032U)
  for i = 0; i < 89; i = i + 1 {
    mt.get_rand() |> ignore
  }
  assert_eq(mt.get_rand(), 2073283336U)
  for i = 0; i < 522; i = i + 1 {
    mt.get_rand() |> ignore
  }
  assert_eq(mt.get_rand(), 1222270187U)
  assert_eq(mt.get_rand(), 1027084080U)
  assert_eq(mt.get_rand(), 3860652269U)
  assert_eq(mt.get_rand(), 657474326U)
  for i = 0; i < 373; i = i + 1 {
    mt.get_rand() |> ignore
  }
  assert_eq(mt.get_rand(), 2673539693U)
}

// Indexプロパティテスト

///|
test "index_progression" {
  let mt = MT::make(5489U)

  // 初期状態
  assert_eq(mt.index(), 0UL)

  // 1回呼び出し後
  mt.get_rand() |> ignore
  assert_eq(mt.index(), 1UL)

  // 10回呼び出し後 (あと9回)
  for i = 0; i < 9; i = i + 1 {
    mt.get_rand() |> ignore
  }
  assert_eq(mt.index(), 10UL)

  // 625回呼び出し後 (あと615回)
  for i = 0; i < 615; i = i + 1 {
    mt.get_rand() |> ignore
  }
  assert_eq(mt.index(), 625UL)

  // 1000回呼び出し後 (あと375回)
  for i = 0; i < 375; i = i + 1 {
    mt.get_rand() |> ignore
  }
  assert_eq(mt.index(), 1000UL)
}

// 長期生成テスト

///|
test "long_term_generation" {
  let mt = MT::make(12345U)

  // 10000回目まで生成
  for i = 0; i < 9999; i = i + 1 {
    mt.get_rand() |> ignore
  }
  assert_eq(mt.get_rand(), 1379954266U)
  assert_eq(mt.index(), 10000UL)

  // 50000回目まで生成 (あと40000回)
  for i = 0; i < 39999; i = i + 1 {
    mt.get_rand() |> ignore
  }
  assert_eq(mt.get_rand(), 115405301U)
  assert_eq(mt.index(), 50000UL)

  // 100000回目まで生成 (あと50000回)
  for i = 0; i < 49999; i = i + 1 {
    mt.get_rand() |> ignore
  }
  assert_eq(mt.get_rand(), 1099245044U)
  assert_eq(mt.index(), 100000UL)
}

// Advance機能テスト - advance_count = 0

///|
test "advance_0" {
  let mt = MT::make(5489U)
  mt.advance(0U)
  assert_eq(mt.index(), 0UL)
  assert_eq(mt.get_rand(), 3499211612U)
  assert_eq(mt.index(), 1UL)
}

// Advance機能テスト - advance_count = 1

///|
test "advance_1" {
  let mt = MT::make(5489U)
  mt.advance(1U)
  assert_eq(mt.index(), 1UL)
  assert_eq(mt.get_rand(), 581869302U)
  assert_eq(mt.index(), 2UL)
}

// Advance機能テスト - advance_count = 10

///|
test "advance_10" {
  let mt = MT::make(5489U)
  mt.advance(10U)
  assert_eq(mt.index(), 10UL)
  assert_eq(mt.get_rand(), 418932835U)
  assert_eq(mt.index(), 11UL)
}

// Advance機能テスト - advance_count = 100

///|
test "advance_100" {
  let mt = MT::make(5489U)
  mt.advance(100U)
  assert_eq(mt.index(), 100UL)
  assert_eq(mt.get_rand(), 1185518681U)
  assert_eq(mt.index(), 101UL)
}

// Advance機能テスト - advance_count = 623

///|
test "advance_623" {
  let mt = MT::make(5489U)
  mt.advance(623U)
  assert_eq(mt.index(), 623UL)
  assert_eq(mt.get_rand(), 4020325887U)
  assert_eq(mt.index(), 624UL)
}

// Advance機能テスト - advance_count = 624

///|
test "advance_624" {
  let mt = MT::make(5489U)
  mt.advance(624U)
  assert_eq(mt.index(), 624UL)
  assert_eq(mt.get_rand(), 4178893912U)
  assert_eq(mt.index(), 625UL)
}

// Advance機能テスト - advance_count = 625

///|
test "advance_625" {
  let mt = MT::make(5489U)
  mt.advance(625U)
  assert_eq(mt.index(), 625UL)
  assert_eq(mt.get_rand(), 610818241U)
  assert_eq(mt.index(), 626UL)
}

// Advance機能テスト - advance_count = 1000

///|
test "advance_1000" {
  let mt = MT::make(5489U)
  mt.advance(1000U)
  assert_eq(mt.index(), 1000UL)
  assert_eq(mt.get_rand(), 2500741117U)
  assert_eq(mt.index(), 1001UL)
}
