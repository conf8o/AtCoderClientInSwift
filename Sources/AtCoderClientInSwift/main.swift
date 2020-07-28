import Foundation

var AtCoderURL: URL? = nil

typealias Rank = String // A, B, C ...
typealias Example = [String] // 入力例
var problemExamples = [Rank: Example?]()

print(WELCOME)

for yourInput: Input in Shell() {
    let command: Command = yourInput.command
    let args: [String] = yourInput.args
    switch command {
    case .help:
        Command.help()
    case .make:
        Command.make(args)
    case .test:
        Command.test(args)
    case .submit:
        Command.submit(args)
    case .url:
        if let url = Command.url(args) {
            AtCoderURL = url
            problemExamples = AtCoderCrawler.getExamples(url: url)
            print("URLを設定しました: ", url.description)
        } else {
            print("AtCoderのサイトを指定してください。")
        }
    case .nothing:
        continue
    case .quit:
        break
    }
}