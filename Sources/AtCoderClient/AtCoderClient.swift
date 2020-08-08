import Foundation

class AtCoderClient {
    var atCoderURL: AtCoderURL?
    var problemSamples: [Rank: Samples]
    var fileMapping: [Rank: String]
    
    init(atCoderURL: AtCoderURL? = nil, problemSamples: [Rank: Samples] = [:], fileMapping: [Rank: String] = [:]) {
        self.atCoderURL = atCoderURL
        self.problemSamples = problemSamples
        self.fileMapping = fileMapping
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
                    print("Bye!")
                    break
                case .help:
                    print(Command.doHelp())
                case .make:
                    let (rank, fileName) = try Command.doMake(args)
                    fileMapping[rank] = fileName
                case .submit:
                    try Command.doSubmit(args)
                case .test:
                    let result = try Command.doTest(args, fileMapping: &fileMapping, problemSamples: &problemSamples)
                    print(result)
                case .url:
                    let (_atCoderURL, _problemSamples) = try Command.doUrl(args)
                    atCoderURL = _atCoderURL
                    problemSamples = _problemSamples
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
