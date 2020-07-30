import Foundation

class AtCoderClient {
    typealias Rank = String // A, B, C ...
    typealias Example = [String] // 入力例
    
    var atCoderURL: URL? = nil
    var problemExamples = [Rank: Example?]()
    
    init(atCoderURL: URL? = nil, problemExamples: [Rank: Example?] = [:]) {
        self.atCoderURL = atCoderURL
        self.problemExamples = problemExamples
    }
        
    func runCLI() {
        print(WELCOME)
        for yourInput: Input in Shell(client: self) {
            let command: Command = yourInput.command
            let args: [String] = yourInput.args
            do {
                switch command {
                case .nothing:
                    continue
                case .quit:
                    break
                case .help:
                    print(Command.help())
                case .make:
                    try Command.make(args)
                case .submit:
                    try Command.submit(args)
                case .test:
                    try Command.test(args)
                case .url:
                    (atCoderURL, problemExamples) = try Command.url(args)
                }
            } catch CommandError.invalidArguments(let message) {
                print(message)
            }
        }
    }
}
