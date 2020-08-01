import Foundation
import Kanna

struct AtCoderCrawler {
    static func getSamples(atCoderURL: AtCoderURL) -> [String: Samples]? {
        guard let contestsPath = atCoderURL.contestsPath, let contest = atCoderURL.contest else { return nil }
        guard let tasksPath = URL(string: "\(contestsPath)\(contest)/tasks") else { return nil }
        do {
            // 問題のURL
            let doc = try HTML(url: tasksPath, encoding: .utf8)
        
            // A xx B yy C zz ...
            let link = doc.xpath("//tbody//a")
            let rankSamples = try link.enumerated().filter { $0.0 % 2 == 0 }.map { _, element -> (String, Samples) in
                // host: atcoder.jp
                // rank: A etc.
                // href: /contests/abc... etc.
                guard let rank = element.text,
                      let href = element["href"] else { throw AtCoderCrawlerError.invalidURL(tasksPath.absoluteString) }
                
                guard let problemURL = URL(string: "https://\(atCoderURL.host)\(href)") else { throw AtCoderCrawlerError.invalidURL(tasksPath.absoluteString) }
                
                let problem = try HTML(url: problemURL, encoding: .utf8)
                let preSamplesIter = problem.xpath("//pre").makeIterator()
                
                // TODO: 入力形式を削除
                // 入力形式を削除
                // let _ = preSamplesIter.next()
                
                var samplesTexts = preSamplesIter.compactMap { tag in tag.text }.makeIterator()
                var inputs = [String]()
                var outputs = [String]()
                while let input = samplesTexts.next(), let output = samplesTexts.next() {
                    inputs.append(input)
                    outputs.append(output)
                }
                let samples = Samples(inputs: inputs, outputs: outputs)
                
                return (rank, samples)
            }
            return Dictionary(uniqueKeysWithValues: rankSamples)
        } catch {
            return nil
        }
    }
}
