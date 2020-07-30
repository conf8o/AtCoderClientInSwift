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

    static func help() {
        print(HELP)
    }

    static func make(_ fileAndProblem: [String]) {
        var iter = fileAndProblem.makeIterator()
        guard let fileName = iter.next(), let problem = iter.next() else {
            print("make コマンド; 引数が足りません。'make fileName A' のように指定してください。")
            return
        }
        print("(TODO) make", fileName, problem)
    }

    static func test(_ fileName_: [String]) {
        var iter = fileName_.makeIterator()
        guard let fileName = iter.next() else {
            print("実行するファイルを1つ指定してください。")
            return
        }
        print("(TODO) test", fileName)
    }

    static func submit(_ fileName_: [String]) {
        var iter = fileName_.makeIterator()
        guard let fileName = iter.next() else {
            print("提出するファイルを1つ指定してください。")
            return
        }
        print("(TODO) submit", fileName)
    }

    static func url(_ urlString: [String], url: inout URL?, examples: inout [String: [String]]) {
        var iter = urlString.makeIterator()
        guard let urlString = iter.next() else {
            print("URLを1つ指定してください。")
            return nil
        }
        
        guard isAtCoderURL(string: urlString), let url_ = URL(string: urlString) else {
            print("AtCoderの問題のURLを指定してください。")
            return nil
        }
        
        url = url_
        examples = AtCoderCrowler.getExamples(url: url)
        print("URLを設定しました。:", url)
    }
    
    private static func isAtCoderURL(string: String) -> Bool {
        return string.hasPrefix(CONTEST_URL_PREFIX)
    }
}
