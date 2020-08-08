import Foundation

extension Command {
    static func doTest(_ rank: [String], fileMapping: inout [Rank: String], problemSamples: inout [Rank: Samples]) throws -> String {
        var iter = rank.makeIterator()
        guard let rankString = iter.next() else {
            throw CommandError.invalidArguments("実行する問題を一つ指定してください。")
        }
        
        guard let _rank = Rank(rawValue: rankString) else {
            throw CommandError.invalidArguments("問題はA...Zを指定してください。")
        }
        
        guard let swiftFileName = fileMapping[_rank] else {
            throw CommandError.invalidArguments("ファイルと問題を紐付けてください。(makeコマンド)")
        }
        
        guard let samples = problemSamples[_rank] else {
            throw CommandError.invalidArguments("入力例の読み込みに失敗。")
        }
        
        if try CodeJugde.judge(swiftFileName: swiftFileName, inputs: samples.inputs, outputs: samples.outputs, { print($0) }) {
            return "All AC"
        } else {
            return "WA"
        }
    }
}
