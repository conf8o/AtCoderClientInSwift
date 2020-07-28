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
    case .nothing:
        continue
    case .quit:
        break
    case .url:
        Command.url(args, url: &AtCoderURL, examples: &problemExamples)
    default:
        Command.exec(command: command, args: args)
    }
}
