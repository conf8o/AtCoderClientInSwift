import Foundation
import Kanna

struct AtCoderCrawler {
    static func getSamples(url: URL) throws -> [String: [String]]? {
        do {
            // 問題のURL
            let doc = try HTML(url: url, encoding: .utf8)
        
            // A xx B yy C zz ...
            let link = doc.xpath("//tbody//a")
            let rankSamples = try link.enumerated().filter { $0.0 % 2 == 0 }.map { _, element -> (String, [String]) in
                // host: atcoder.jp
                // rank: A etc.
                // href: /contests/abc... etc.
                guard let host = url.host,
                      let rank = element.text,
                      let href = element["href"] else { throw AtCoderCrawlerError.invalidURL(url.absoluteString) }
                
                guard let problemURL = URL(string: "https://\(host)\(href)") else { throw AtCoderCrawlerError.invalidURL(url.absoluteString) }
                
                let problem = try HTML(url: problemURL, encoding: .utf8)
                let samplesIter = problem.xpath("//pre").makeIterator()
                // 入力形式を削除
                let _ = samplesIter.next()
                
                let samples = samplesIter.compactMap { tag in tag.text }
                return (rank, samples)
            }
            return Dictionary(uniqueKeysWithValues: rankSamples)
        } catch {
            return nil
        }
    }
}
