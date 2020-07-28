enum Command: String {
    case help = "help"
    case test = "test"
    case submit = "submit"
    case quit = "quit"
    case nothing

    static let problems: Set = ["a", "b", "c", "d", "e", "f"]

    static func help() {
        print("help TODO")
    }

    static func test(_ problems: [String]) {
        print("test", problems)
    }

    static func submit(_ problems: [String]) {
        print("submit TODO", problems)
    }
}