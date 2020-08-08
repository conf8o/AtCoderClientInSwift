import Foundation

extension Command {
    static func doMake(_ fileAndProblem: [String]) throws -> (Rank, String) {
        var iter = fileAndProblem.makeIterator()
        guard let fileName = iter.next(), let problem = iter.next() else {
           throw CommandError.invalidArguments("makeコマンドの引数が足りません。'make fileName A' のように指定してください。")
        }
        
        guard let rank = Rank(rawValue: problem) else {
            throw CommandError.invalidArguments("makeコマンドの第二引数(問題)は英大文字(A...Z)から選んでください")
        }
        
        let fileManager = FileManager.default
        let swiftFileName = "\(fileName).swift"
        
        if fileManager.fileExists(atPath: swiftFileName)
            || fileManager.createFile(atPath: swiftFileName, contents: "".data(using: .utf8)) {
            return (rank, swiftFileName)
        } else {
            throw CommandError.invalidArguments("ファイルを作成できませんでした。")
        }
    }
}
