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

    static func help() {
        print(HELP)
    }

    static func make(_ problems: [String]) {
        print("make", problems)
    }

    static func test(_ fileName: [String]) {
        print("test", fileName)
    }

    static func submit(_ fileName: [String]) {
        print("submit TODO", fileName)
    }

    static func url(_ url: [String]) -> URL? {
        return URL(string: "https://developer.apple.com/documentation/foundation/url")
    }
}