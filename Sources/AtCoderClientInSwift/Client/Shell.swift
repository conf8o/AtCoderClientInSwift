import Foundation

struct Input {
    let command: Command
    let args: [String]

    init(command: Command, args: [String]) {
        self.command = command
        self.args = args
    }

    init?(rawInput: String) {
        var commands = rawInput.split(separator: " ").map(String.init)

        guard commands.count > 0 else { return nil }

        if Command.problems.contains(commands[0]) {
            commands = [Command.test.rawValue, commands[0]]
        }

        guard let command = Command(rawValue: commands[0]) else {
            print("No such command \(commands[0])")
            return nil
        }
        
        self.command = command
        self.args = commands.count > 1 ? Array(commands[1...]) : []
    }
}

struct Shell: IteratorProtocol, Sequence {
    var buffer: [Input] = []

    mutating func next() -> Input? {
        guard AtCoderURL != nil else {
            print("AtCoder問題URL >> ", terminator: "")
            let urlString = readLine()!
            return Input(command: .url, args: [urlString])
        }

        print("AtCoder Client >> ", terminator: "")
        return readLine().flatMap { line in
            guard let input = Input(rawInput: line) else { 
                return Input(command: .nothing, args: [])
            }

            if input.command == .quit {
                return nil
            }
            
            buffer.append(input)

            return input
        }
    }
}

