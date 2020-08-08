import Foundation

extension Command {
    static func doMake(_ fileAndProblem: [String]) throws {
        var iter = fileAndProblem.makeIterator()
        guard let fileName = iter.next(), let problem = iter.next() else {
           throw CommandError.invalidArguments("make コマンド; 引数が足りません。'make fileName A' のように指定してください。")
        }
        print("(TODO) make", fileName, problem)
    }
}
