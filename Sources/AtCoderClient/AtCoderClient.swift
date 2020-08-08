import Foundation

class AtCoderClient {
    typealias Rank = String // A, B, C ...
    
    var atCoderURL: AtCoderURL?
    var problemSamples: [Rank: Samples]?
    
    init(atCoderURL: AtCoderURL? = nil, problemSamples: [Rank: Samples]? = nil) {
        self.atCoderURL = atCoderURL
        self.problemSamples = problemSamples
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
                    print(Command.doHelp())
                case .make:
                    try Command.doMake(args)
                case .submit:
                    try Command.doSubmit(args)
                case .test:
                    try Command.doTest(args)
                case .url:
                    (atCoderURL, problemSamples) = try Command.doUrl(args)
                }
            } catch CommandError.invalidArguments(let message) {
                print(message)
            } catch {
                print(error)
                break
            }
        }
    }
}
