import Foundation

struct AtCoderURL {
    enum Sub: String {
        case contests = "contests"
        
        static func isContests(path: String) -> Bool {
            return path.contains(Sub.contests.rawValue)
        }
    }
    var url: URL?
    
    private var sub: Sub?
    private var _pathComponents: [String] = []
    
    var pathComponents: [String] { return _pathComponents }
    var host: String = "atcoder.jp"
    var contestsPath: String? {
        if sub == .contests && _pathComponents.count > 1 {
            return "http://\(host)/\(Sub.contests.rawValue)/"
        } else {
            return nil
        }
    }
    var contest: String? {
        if sub == .contests && _pathComponents.count > 2 {
            // _pathComponentsは例えば https://atcoder.jp/contests/abc173 => ["/", "contests", "abc173"]
            // のようになっているので、3番目がコンテストになる。
            return _pathComponents[2]
        } else {
            return nil
        }
    }
    
    init?(string: String) {
        guard isAtCoderURL(string: string), let url = URL(string: string) else { return nil }
        
        self.url = url
        self._pathComponents = url.pathComponents
        
        if Sub.isContests(path: string) {
            self.sub = .contests
        } else {
            self.sub = nil
        }
    }
    
    private func isAtCoderURL(string: String) -> Bool {
        return string.hasPrefix(CONTEST_URL_PREFIX)
    }
}
