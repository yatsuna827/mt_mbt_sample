# MoonBit MT19937 乱数生成器

メルセンヌツイスタ (MT19937) 擬似乱数生成器のMoonBit実装です。

## ビルド

```bash
moon build --target js
```

ビルド後、`target/js/release/build/mt_mbt_sample.js` が生成されます。

## 使用方法

### Node.js

```javascript
import { make, get_rand, advance, index } from './target/js/release/build/mt_mbt_sample.js';

// MTインスタンスを作成 (シード値: 5489)
const mt = make(5489);

// 乱数を生成
const rand = get_rand(mt);
console.log(rand >>> 0); // 符号なし整数として表示

// n個の乱数をスキップ
advance(mt, 100);

// 生成した乱数の総数を取得
const count = index(mt);
console.log(count); // { hi: number, lo: number } 形式のUInt64
```

### ブラウザ (ES Modules)

```html
<script type="module">
    import { make, get_rand, advance, index } from './target/js/release/build/mt_mbt_sample.js';

    const mt = make(12345);
    const rand = get_rand(mt);
    console.log(rand >>> 0);
</script>
```

## API

### `make(seed: number): MT`

新しいメルセンヌツイスタインスタンスを作成します。

- **引数**: `seed` - 符号なし32ビット整数のシード値
- **戻り値**: MTインスタンス

```javascript
const mt = make(5489);
```

### `get_rand(mt: MT): number`

32ビット符号なし整数の乱数を生成します。

- **引数**: `mt` - MTインスタンス
- **戻り値**: 32ビット整数 (JavaScriptでは符号付きとして返されるため、`>>> 0`で符号なしに変換)

```javascript
const rand = get_rand(mt);
const unsigned = rand >>> 0; // 符号なし整数として扱う
```

### `advance(mt: MT, n: number): void`

n回の乱数生成をスキップします。

- **引数**:
  - `mt` - MTインスタンス
  - `n` - スキップする回数
- **戻り値**: なし

```javascript
advance(mt, 100);
```

### `index(mt: MT): UInt64`

生成した乱数の総数を取得します。

- **引数**: `mt` - MTインスタンス
- **戻り値**: `{ hi: number, lo: number }` 形式のUInt64オブジェクト

```javascript
const count = index(mt);
console.log(`Hi: ${count.hi}, Lo: ${count.lo}`);
```

## サンプルコード

プロジェクトには2種類のサンプルコードが含まれています:

1. **MoonBitサンプル** - `example/main.mbt`
2. **Node.jsサンプル** - `example.mjs`

### 実行方法

#### MoonBit (exampleサブパッケージ)
```bash
moon run example --target js
```

このサンプルは、MoonBitから直接MTライブラリを使用する例です。

#### Node.js
```bash
node example.mjs
```

このサンプルは、コンパイルされたJavaScriptライブラリをNode.jsから使用する例です。

### 実用的な使用例

#### 特定範囲の整数を生成

```javascript
import { make, get_rand } from './target/js/release/build/mt_mbt_sample.js';

const mt = make(777);

// 0-100の範囲
const rand = get_rand(mt);
const inRange = (rand >>> 0) % 101;

// 1-6の範囲 (サイコロ)
const dice = ((rand >>> 0) % 6) + 1;
```

#### 浮動小数点数 [0, 1) を生成

```javascript
const rand = get_rand(mt);
const float = (rand >>> 0) / 0xFFFFFFFF;
```

#### 配列からランダムに選択

```javascript
function randomChoice(mt, array) {
    const rand = get_rand(mt);
    const index = (rand >>> 0) % array.length;
    return array[index];
}

const fruits = ['りんご', 'バナナ', 'オレンジ'];
const choice = randomChoice(mt, fruits);
```

#### 配列をシャッフル

```javascript
function shuffle(mt, array) {
    const result = [...array];
    for (let i = result.length - 1; i > 0; i--) {
        const rand = get_rand(mt);
        const j = (rand >>> 0) % (i + 1);
        [result[i], result[j]] = [result[j], result[i]];
    }
    return result;
}

const numbers = [1, 2, 3, 4, 5];
const shuffled = shuffle(mt, numbers);
```

## 注意事項

- JavaScriptの数値は符号付き32ビット整数として扱われるため、符号なし整数として使用する場合は `>>> 0` を使用してください
- MT19937は暗号学的に安全ではないため、セキュリティ用途には使用しないでください
- 同じシード値から生成される乱数列は常に同じです (再現性)

## ライセンス

Apache-2.0

## MoonBit実装

このライブラリはMoonBitで実装されています。元のソースコードは `mt.mbt` を参照してください。

MoonBitについての詳細: https://www.moonbitlang.com/