import Foundation

enum Command: String {
    case help = "help"
    case make = "make"
    case test = "test"
    case submit = "submit"
    case quit = "quit"
    case url = "url"
    case nothing

    static let problems = "A"..."Z"
}
