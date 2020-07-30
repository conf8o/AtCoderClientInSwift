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
        
    func run() {
        print(WELCOME)
        for yourInput: Input in Shell(client: self) {
            let command: Command = yourInput.command
            let args: [String] = yourInput.args
            switch command {
            case .nothing:
                continue
            case .quit:
                break
            case .help:
                Command.help()
            case .make:
                Command.make(args)
            case .submit:
                Command.submit(args)
            case .test:
                Command.test(args)
            case .url:
                Command.url(args, url: &atCoderURL, examples: &problemExamples)
            }
        }
    }
}
