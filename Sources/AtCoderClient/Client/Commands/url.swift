import Foundation

extension Command {
    static func doUrl(_ urlString: [String]) throws -> (AtCoderURL, [String: Samples]?) {
        var iter = urlString.makeIterator()
        guard let urlString = iter.next() else {
            throw CommandError.invalidArguments("URLを1つ指定してください。")
        }
        
        guard let url = AtCoderURL(string: urlString) else {
            throw CommandError.invalidArguments("AtCoderのコンテストのURLを指定してください。")
        }
        let info = (url, AtCoderCrawler.getSamples(atCoderURL: url))
        return info
    }
}
