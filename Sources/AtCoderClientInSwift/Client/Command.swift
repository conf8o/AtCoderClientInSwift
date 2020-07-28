import Foundation

enum Command: String {
    case help = "help"
    case make = "make"
    case test = "test"
    case submit = "submit"
    case quit = "quit"
    case url = "url"
    case nothing

    static let problems: Set = ["A", "B", "C"]
    
    static func exec(command: Command, args: [String]) {
        switch command {
        case .help:
            help()
        case .make:
            make(args)
        case .test:
            test(args)
        case .submit:
            submit(args)
        default: break
        }
    }

    static func help() {
        print(HELP)
    }

    static func make(_ fileAndProblem: [String]) {
        var iter = fileAndProblem.makeIterator()
        guard let fileName = iter.next(), let problem = iter.next() else {
            print("make コマンド; 引数が足りません。'make fileName A' のように指定してください。")
            return
        }
        print("make", fileName, problem)
    }

    static func test(_ fileName_: [String]) {
        var iter = fileName_.makeIterator()
        guard let fileName = iter.next() else {
            print("実行するファイルを1つ指定してください。")
            return
        }
        print("test", fileName)
    }

    static func submit(_ fileName_: [String]) {
        var iter = fileName_.makeIterator()
        guard let fileName = iter.next() else {
            print("提出するファイルを1つ指定してください。")
            return
        }
        print("submit TODO", fileName)
    }

    static func url(_ urlString_: [String], url: inout URL?, examples: inout [String: [String]?]) {
        var iter = urlString_.makeIterator()
        guard let urlString = iter.next() else {
            print("URLを1つ指定してください。")
            return
        }
        
        guard isAtCoderURL(string: urlString), let url_ = URL(string: urlString) else {
            print("AtCoderの問題のURLを指定してください。")
            return
        }
        
        url = url_
        examples = AtCoderCrawler.getExamples(url: url_)
        print("URLを設定しました:", url_.description)
    }
    
    private static func isAtCoderURL(string: String) -> Bool {
        return string.hasPrefix(CONTEST_URL_PREFIX)
    }
}
