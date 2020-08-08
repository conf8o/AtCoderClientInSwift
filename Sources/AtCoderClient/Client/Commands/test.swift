import Foundation

extension Command {
    static func doTest(_ fileName: [String]) throws {
        var iter = fileName.makeIterator()
        guard let _fileName = iter.next() else {
            throw CommandError.invalidArguments("実行するファイルを1つ指定してください。")
        }
        print("(TODO) test", _fileName)
    }
}
