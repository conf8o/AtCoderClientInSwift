import Foundation

struct Input {
    let command: Command
    let args: [String]

    init(command: Command, args: [String]) {
        self.command = command
        self.args = args
    }

    static func fromCLI() -> Input? {
        guard let line = readLine() else { return nil }
        
        var commands = line.split(separator: " ").map(String.init)
        guard commands.count > 0 else {
            return Input(command: .nothing, args: [])
        }

        if Command.problems.contains(commands[0]) {
            commands = [Command.test.rawValue, commands[0]]
        }

        guard let command = Command(rawValue: commands[0]) else {
            print("No such command \(commands[0])")
            return Input(command: .nothing, args: [])
        }
        
        return Input(command: command, args: commands.count > 1 ? Array(commands[1...]) : [])
    }
}

struct Shell: IteratorProtocol, Sequence {
    var buffer: [Input] = []
    let client: AtCoderClient
    
    init(client: AtCoderClient) {
        self.client = client
    }
    
    mutating func next() -> Input? {
        guard let atCoderURL = client.atCoderURL else {
            print("AtCoderコンテストURL> ", terminator: "")
            let urlString = readLine()!
            return Input(command: .url, args: [urlString])
        }

        print("\(atCoderURL.contest ?? "AtCoderコンテストURL")> ", terminator: "")
        
        return Input.fromCLI().flatMap { input in

            if input.command == .quit {
                return nil
            }
            
            buffer.append(input)

            return input
        }
    }
}

