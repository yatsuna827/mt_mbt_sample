///|
fn main {
  // メルセンヌツイスタのサンプル

  // シード値5489で初期化
  let mt = MT::new(5489U)
  println("=== メルセンヌツイスタ MT19937 デモ ===\n")

  // 最初の10個の乱数を生成
  println("最初の10個の乱数:")
  for i = 0; i < 10; i = i + 1 {
    let rand = mt.get_rand()
    println("  \{i + 1}: \{rand} (0x\{rand.to_string(radix=16)})")
  }

  // 現在の生成数を確認
  println("\n生成した乱数の総数: \{mt.index()}")

  // advance機能のデモ
  println("\n100個スキップ...")
  mt.advance(100U)
  println("現在の生成数: \{mt.index()}")

  // スキップ後の乱数
  println("\n次の5個の乱数:")
  for i = 0; i < 5; i = i + 1 {
    let rand = mt.get_rand()
    println("  \{mt.index()}: \{rand}")
  }

  // 別のシードで新しいインスタンスを作成
  println("\n=== シード12345で新しいインスタンス ===")
  let mt2 = MT::new(12345U)
  println("最初の5個の乱数:")
  for i = 0; i < 5; i = i + 1 {
    let rand = mt2.get_rand()
    println("  \{i + 1}: \{rand}")
  }

  // 大きな範囲での動作確認
  println("\n=== 大量生成テスト ===")
  let mt3 = MT::new(42U)
  for i = 0; i < 10000; i = i + 1 {
    mt3.get_rand() |> ignore
  }
  println("10,000個生成完了")
  println("次の乱数: \{mt3.get_rand()}")
  println("総生成数: \{mt3.index()}")
}
