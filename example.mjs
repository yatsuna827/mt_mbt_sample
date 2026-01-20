/**
 * MoonBit MT19937 乱数生成器 - Node.js サンプル
 *
 * 使用方法:
 *   node example.mjs
 */

import { make, get_rand, advance, index } from './target/js/release/build/mt_mbt_sample.js';

// ヘルパー関数: 符号なし整数として表示
function toUnsigned(value) {
    return value >>> 0;
}

// メルセンヌツイスタのサンプル

// シード値5489で初期化
const mt = make(5489);
console.log('=== メルセンヌツイスタ MT19937 デモ ===\n');

// 最初の10個の乱数を生成
console.log('最初の10個の乱数:');
for (let i = 0; i < 10; i++) {
    const rand = get_rand(mt);
    console.log(`  ${i + 1}: ${toUnsigned(rand)} (0x${toUnsigned(rand).toString(16)})`);
}

// 現在の生成数を確認
const count = index(mt);
console.log(`\n生成した乱数の総数: ${count.lo}`);

// advance機能のデモ
console.log('\n100個スキップ...');
advance(mt, 100);
console.log(`現在の生成数: ${index(mt).lo}`);

// スキップ後の乱数
console.log('\n次の5個の乱数:');
for (let i = 0; i < 5; i++) {
    const rand = get_rand(mt);
    console.log(`  ${index(mt).lo}: ${toUnsigned(rand)}`);
}

// 別のシードで新しいインスタンスを作成
console.log('\n=== シード12345で新しいインスタンス ===');
const mt2 = make(12345);
console.log('最初の5個の乱数:');
for (let i = 0; i < 5; i++) {
    const rand = get_rand(mt2);
    console.log(`  ${i + 1}: ${toUnsigned(rand)}`);
}

// 大きな範囲での動作確認
console.log('\n=== 大量生成テスト ===');
const mt3 = make(42);
for (let i = 0; i < 10000; i++) {
    get_rand(mt3);
}
console.log('10,000個生成完了');
console.log(`次の乱数: ${toUnsigned(get_rand(mt3))}`);
console.log(`総生成数: ${index(mt3).lo}`);
