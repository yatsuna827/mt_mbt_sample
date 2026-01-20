# メルセンヌツイスタ MoonBit移植 テストデータ要件

## 概要

このドキュメントは、C#からMoonBitへのメルセンヌツイスタ(MT19937)移植における、テストケース作成に必要なデータを定義します。

すべてのテストは外部から観測可能なAPI（`GetRand()`, `Index`, `Advance()`）の振る舞いのみを検証します。

## 必要なテストデータ

### 1. 基本的な乱数生成シーケンステスト

各初期シード値から`GetRand()`を連続呼び出しした時の出力値を記録します。

**必要なシード値:**
- `5489` (MT19937の標準テストシード)
- `0`
- `1`
- `12345`
- `0xFFFFFFFF` (4294967295)

**各シードについて記録が必要な値:**
- 最初の1000個の`GetRand()`の戻り値
- または、最低限以下の位置での値:
  - 呼び出し回数: 1, 2, 3, 10, 100, 623, 624, 625, 626, 1000

**データ形式例:**
```json
{
  "seed": 5489,
  "outputs": [
    {"call_number": 1, "value": 3499211612},
    {"call_number": 2, "value": 581869302},
    {"call_number": 3, "value": 3890346734},
    ...
  ]
}
```

### 2. Indexプロパティの検証テスト

`GetRand()`呼び出しと`Index`プロパティの対応を確認します。

**必要なデータ:**
- シード値: `5489`
- 各`GetRand()`呼び出し後の`Index`プロパティの値

**検証ポイント:**
- 初期化直後: `Index = 0`
- 1回呼び出し後: `Index = 1`
- N回呼び出し後: `Index = N`

**データ形式例:**
```json
{
  "seed": 5489,
  "index_progression": [
    {"after_calls": 0, "index": 0},
    {"after_calls": 1, "index": 1},
    {"after_calls": 10, "index": 10},
    {"after_calls": 625, "index": 625},
    {"after_calls": 1000, "index": 1000}
  ]
}
```

### 3. 長期間の乱数生成テスト

状態ベクトルの更新が複数回行われた後も正しく動作することを確認します。

**必要なデータ:**
- シード値: `12345`
- 大量呼び出し後の特定位置での値:
  - 10000回目
  - 50000回目
  - 100000回目

**データ形式例:**
```json
{
  "seed": 12345,
  "long_term_outputs": [
    {"call_number": 10000, "value": ..., "index": 10000},
    {"call_number": 50000, "value": ..., "index": 50000},
    {"call_number": 100000, "value": ..., "index": 100000}
  ]
}
```

### 4. Advance機能のテスト

`Advance(n)`を呼んだ後、次の`GetRand()`が正しい値を返すことを確認します。

**検証する等価性:**
```
初期化 → Advance(n) → GetRand() の値
==
初期化 → GetRand()をn回呼ぶ → GetRand() の値
```

**必要なデータ:**
- シード値: `5489`
- 様々な`n`について、`Advance(n)`後の最初の`GetRand()`の値:
  - n = 0, 1, 10, 100, 623, 624, 625, 1000

**データ形式例:**
```json
{
  "seed": 5489,
  "advance_tests": [
    {
      "advance_count": 0,
      "next_value": 3499211612,
      "index_after_advance": 0,
      "index_after_getrand": 1
    },
    {
      "advance_count": 1,
      "next_value": 581869302,
      "index_after_advance": 1,
      "index_after_getrand": 2
    },
    {
      "advance_count": 10,
      "next_value": ...,
      "index_after_advance": 10,
      "index_after_getrand": 11
    },
    ...
  ]
}
```

## データ生成方法

元のC#実装を使用して、上記のすべてのケースについてデータを生成してください。

各テストケースは独立したJSONファイルまたは統合されたJSONファイルとして提供してください。

## 注意事項

- すべての乱数値はuint32 (0～4294967295) の範囲です
- `Index`はuint64ですが、テスト範囲内ではuint32で表現可能です
- 内部実装（状態ベクトル、Temper関数など）のテストは含めません
- 外部APIの振る舞い（`GetRand()`, `Index`, `Advance()`）のみを検証します
