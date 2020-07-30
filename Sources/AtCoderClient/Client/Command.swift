import Foundation

enum Command: String {
    case help = "help"
    case make = "make"
    case test = "test"
    case submit = "submit"
    case quit = "quit"
    case url = "url"
    case nothing

    static let problems = "A"..."Z"

    static func help() -> String {
        return HELP
    }

    static func make(_ fileAndProblem: [String]) throws {
        var iter = fileAndProblem.makeIterator()
        guard let fileName = iter.next(), let problem = iter.next() else {
           throw CommandError.invalidArguments("make コマンド; 引数が足りません。'make fileName A' のように指定してください。")
        }
        print("(TODO) make", fileName, problem)
    }

    static func test(_ fileName: [String]) throws {
        var iter = fileName.makeIterator()
        guard let _fileName = iter.next() else {
            throw CommandError.invalidArguments("実行するファイルを1つ指定してください。")
        }
        print("(TODO) test", _fileName)
    }

    static func submit(_ fileName: [String]) throws {
        var iter = fileName.makeIterator()
        guard let _fileName = iter.next() else {
            throw CommandError.invalidArguments("提出するファイルを1つ指定してください。")
        }
        print("(TODO) submit", _fileName)
    }

    static func url(_ urlString: [String]) throws -> (URL, [String: [String]]) {
        var iter = urlString.makeIterator()
        guard let urlString = iter.next() else {
            throw CommandError.invalidArguments("URLを1つ指定してください。")
        }
        
        guard isAtCoderURL(string: urlString), let _url = URL(string: urlString) else {
            throw CommandError.invalidArguments("AtCoderの問題のURLを指定してください。")
        }
        
        let info = (_url, AtCoderCrowler.getExamples(url: url))
        return info
    }
    
    private static func isAtCoderURL(string: String) -> Bool {
        return string.hasPrefix(CONTEST_URL_PREFIX)
    }
}
