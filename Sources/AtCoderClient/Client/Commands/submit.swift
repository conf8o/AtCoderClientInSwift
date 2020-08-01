import Foundation

extension Command {
    static func doSubmit(_ fileName: [String]) throws {
        var iter = fileName.makeIterator()
        guard let _fileName = iter.next() else {
            throw CommandError.invalidArguments("提出するファイルを1つ指定してください。")
        }
        print("(TODO) submit", _fileName)
    }
}
