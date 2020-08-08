import Foundation

struct AtCoderURL {
    enum Sub: String {
        case contests = "contests"
        
        static func isContests(path: String) -> Bool {
            return path.contains(Sub.contests.rawValue)
        }
    }
    static let host: String = ATCODER_HOST
    static let contestsPath: String = "https://\(host)/\(Sub.contests.rawValue)/"
    
    private var sub: Sub?
    private var _url: URL?
    private var _pathComponents: [String] = []
    
    var url: URL? { return _url }
    var pathComponents: [String] { return _pathComponents }
    var contest: String? {
        if sub == .contests && _pathComponents.count > 2 {
            // _pathComponentsは例えば https://atcoder.jp/contests/abc173 => ["/", "contests", "abc173"]
            // のようになっているので、2番目がコンテストになる。
            return _pathComponents[2]
        } else {
            return nil
        }
    }
    
    init?(string: String) {
        guard isAtCoderURL(string: string), let url = URL(string: string) else { return nil }
        
        self._url = url
        self._pathComponents = url.pathComponents
        
        if Sub.isContests(path: string) {
            self.sub = .contests
        } else {
            self.sub = nil
        }
    }
    
    private func isAtCoderURL(string: String) -> Bool {
        return string.hasPrefix("https://\(AtCoderURL.host)")
    }
}
