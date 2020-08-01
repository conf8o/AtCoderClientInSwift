import Foundation

extension Command {
    static func doUrl(_ urlString: [String]) throws -> (URL, [AtCoderClient.Rank: AtCoderClient.Samples]?) {
        var iter = urlString.makeIterator()
        guard let urlString = iter.next() else {
            throw CommandError.invalidArguments("URLを1つ指定してください。")
        }
        
        guard isAtCoderURL(string: urlString), let _url = URL(string: urlString) else {
            throw CommandError.invalidArguments("AtCoderの問題のURLを指定してください。")
        }
        let info = (_url, try AtCoderCrawler.getSamples(url: _url))
        return info
    }
    
    private static func isAtCoderURL(string: String) -> Bool {
        return string.hasPrefix(CONTEST_URL_PREFIX)
    }
}
