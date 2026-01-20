// メルセンヌツイスタ MT19937 実装
// C#実装からの移植

// 定数定義

///|
const N : Int = 624

///|
const M : Int = 397

///|
const MATRIX_A : UInt = 0x9908b0dfU

///|
const UPPER_MASK : UInt = 0x80000000U

///|
const LOWER_MASK : UInt = 0x7fffffffU

///|
const SEED_MULTIPLIER : UInt = 0x6C078965U

// メルセンヌツイスタの状態を保持する構造体

///|
struct MT {
  state_vector : FixedArray[UInt] // 624要素の状態ベクトル
  mut index : UInt64 // 生成した乱数の総数
  mut rand_index : Int // 状態ベクトル内の位置(0-623)
}

// Temper関数 - 4段階のビット操作による出力の調整

///|
fn temper(y : UInt) -> UInt {
  let mut result = y
  result = result ^ (result >> 11)
  result = result ^ ((result << 7) & 0x9d2c5680U)
  result = result ^ ((result << 15) & 0xefc60000U)
  result = result ^ (result >> 18)
  result
}

// シード値から状態ベクトルを初期化

///|
fn init_state_vector(seed : UInt) -> FixedArray[UInt] {
  let state = FixedArray::make(N, 0U)
  state[0] = seed
  for i = 1; i < N; i = i + 1 {
    let prev = state[i - 1]
    state[i] = SEED_MULTIPLIER * (prev ^ (prev >> 30)) + i.reinterpret_as_uint()
  }
  state
}

// 状態ベクトルを更新する関数

///|
fn MT::update(self : MT) -> Unit {
  // ループ1: k = 0 to 226 (N - M - 1)
  for k = 0; k < N - M; k = k + 1 {
    let temp = (self.state_vector[k] & UPPER_MASK) |
      (self.state_vector[k + 1] & LOWER_MASK)
    self.state_vector[k] = self.state_vector[k + M] ^ (temp >> 1)
    if (temp & 1U) == 1U {
      self.state_vector[k] = self.state_vector[k] ^ MATRIX_A
    }
  }

  // ループ2: k = 227 to 622 (N - M to N - 2)
  for k = N - M; k < N - 1; k = k + 1 {
    let temp = (self.state_vector[k] & UPPER_MASK) |
      (self.state_vector[k + 1] & LOWER_MASK)
    self.state_vector[k] = self.state_vector[k + (M - N)] ^ (temp >> 1)
    if (temp & 1U) == 1U {
      self.state_vector[k] = self.state_vector[k] ^ MATRIX_A
    }
  }

  // ループ3: k = 623 (循環参照)
  let temp = (self.state_vector[N - 1] & UPPER_MASK) |
    (self.state_vector[0] & LOWER_MASK)
  self.state_vector[N - 1] = self.state_vector[M - 1] ^ (temp >> 1)
  if (temp & 1U) == 1U {
    self.state_vector[N - 1] = self.state_vector[N - 1] ^ MATRIX_A
  }
}

// コンストラクタ - シード値からMTインスタンスを作成

///|
pub fn MT::make(seed : UInt) -> MT {
  { state_vector: init_state_vector(seed), index: 0UL, rand_index: N } // 初回でupdate()を呼ぶため
}

// 32ビット符号なし整数の乱数を生成

///|
pub fn MT::get_rand(self : MT) -> UInt {
  if self.rand_index >= N {
    self.update()
    self.rand_index = 0
  }
  self.index = self.index + 1UL
  let result = temper(self.state_vector[self.rand_index])
  self.rand_index = self.rand_index + 1
  result
}

// 生成した乱数の総数を取得

///|
pub fn MT::index(self : MT) -> UInt64 {
  self.index
}

// n回乱数生成をスキップする

///|
pub fn MT::advance(self : MT, n : UInt) -> Unit {
  for i = 0; i < n.reinterpret_as_int(); i = i + 1 {
    self.get_rand() |> ignore
  }
}
