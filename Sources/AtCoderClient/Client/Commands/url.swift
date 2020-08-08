import Foundation

extension Command {
    static func doUrl(_ urlString: [String]) throws -> (AtCoderURL, [Rank: Samples]) {
        var iter = urlString.makeIterator()
        guard let urlString = iter.next() else {
            throw CommandError.invalidArguments("URLを1つ指定してください。")
        }
        
        guard let url = AtCoderURL(string: urlString) else {
            throw CommandError.invalidArguments("AtCoderのコンテストのURLを指定してください。")
        }
        
        guard let samples = AtCoderCrawler.getSamples(atCoderURL: url) else {
            throw CommandError.invalidArguments("入力例を取得できませんでした。URLを再度確認してください。")
        }
        return (url, samples)
    }
}
