using System;
using System.Collections.Generic;
using System.Text.Json;
using System.IO;
using PokemonPRNG.MT;

namespace TestDataGenerator
{
    class Program
    {
        static void Main(string[] args)
        {
            var allTestData = new Dictionary<string, object>();

            // 1. 基本的な乱数生成シーケンステスト
            Console.WriteLine("Generating basic sequence tests...");
            allTestData["basic_sequence_tests"] = GenerateBasicSequenceTests();

            // 2. Indexプロパティの検証テスト
            Console.WriteLine("Generating index progression tests...");
            allTestData["index_progression_tests"] = GenerateIndexProgressionTests();

            // 3. 長期間の乱数生成テスト
            Console.WriteLine("Generating long term tests...");
            allTestData["long_term_tests"] = GenerateLongTermTests();

            // 4. Advance機能のテスト
            Console.WriteLine("Generating advance tests...");
            allTestData["advance_tests"] = GenerateAdvanceTests();

            // JSON出力
            var options = new JsonSerializerOptions
            {
                WriteIndented = true,
                PropertyNamingPolicy = JsonNamingPolicy.CamelCase
            };

            string json = JsonSerializer.Serialize(allTestData, options);

            // ファイルに出力
            string outputPath = "test_data.json";
            File.WriteAllText(outputPath, json);

            Console.WriteLine($"\nTest data written to: {outputPath}");
            Console.WriteLine($"File size: {new FileInfo(outputPath).Length} bytes");
        }

        static List<object> GenerateBasicSequenceTests()
        {
            var tests = new List<object>();
            uint[] seeds = { 5489, 0, 1, 12345, 0xFFFFFFFF };
            int[] positions = { 1, 2, 3, 10, 100, 623, 624, 625, 626, 1000 };

            foreach (var seed in seeds)
            {
                var mt = new MT(seed);
                var outputs = new List<object>();

                // 1000個生成して、必要な位置の値を記録
                for (int i = 1; i <= 1000; i++)
                {
                    uint value = mt.GetRand();
                    if (Array.IndexOf(positions, i) >= 0)
                    {
                        outputs.Add(new
                        {
                            call_number = i,
                            value = value
                        });
                    }
                }

                tests.Add(new
                {
                    seed = seed,
                    outputs = outputs
                });
            }

            return tests;
        }

        static List<object> GenerateIndexProgressionTests()
        {
            var tests = new List<object>();
            uint seed = 5489;
            var mt = new MT(seed);
            int[] checkPoints = { 0, 1, 10, 625, 1000 };

            var progression = new List<object>();

            // 初期状態
            progression.Add(new
            {
                after_calls = 0,
                index = (long)mt.Index
            });

            // 各チェックポイントまで実行
            int currentCalls = 0;
            foreach (var checkpoint in checkPoints)
            {
                if (checkpoint == 0) continue;

                // チェックポイントまで実行
                for (int i = currentCalls; i < checkpoint; i++)
                {
                    mt.GetRand();
                }
                currentCalls = checkpoint;

                progression.Add(new
                {
                    after_calls = checkpoint,
                    index = (long)mt.Index
                });
            }

            tests.Add(new
            {
                seed = seed,
                index_progression = progression
            });

            return tests;
        }

        static List<object> GenerateLongTermTests()
        {
            var tests = new List<object>();
            uint seed = 12345;
            var mt = new MT(seed);
            int[] positions = { 10000, 50000, 100000 };

            var outputs = new List<object>();

            for (int i = 1; i <= positions[positions.Length - 1]; i++)
            {
                uint value = mt.GetRand();
                if (Array.IndexOf(positions, i) >= 0)
                {
                    outputs.Add(new
                    {
                        call_number = i,
                        value = value,
                        index = (long)mt.Index
                    });
                }
            }

            tests.Add(new
            {
                seed = seed,
                long_term_outputs = outputs
            });

            return tests;
        }

        static List<object> GenerateAdvanceTests()
        {
            var tests = new List<object>();
            uint seed = 5489;
            uint[] advanceCounts = { 0, 1, 10, 100, 623, 624, 625, 1000 };

            var advanceTests = new List<object>();

            foreach (var n in advanceCounts)
            {
                var mt = new MT(seed);
                mt.Advance(n);

                ulong indexAfterAdvance = mt.Index;
                uint nextValue = mt.GetRand();
                ulong indexAfterGetRand = mt.Index;

                advanceTests.Add(new
                {
                    advance_count = n,
                    next_value = nextValue,
                    index_after_advance = (long)indexAfterAdvance,
                    index_after_getrand = (long)indexAfterGetRand
                });
            }

            tests.Add(new
            {
                seed = seed,
                advance_tests = advanceTests
            });

            return tests;
        }
    }
}
