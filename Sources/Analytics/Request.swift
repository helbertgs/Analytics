#if canImport(UIKit)
import UIKit

public enum Request {

    // MARK: Alias.

    typealias Params = [String: Any]

    // MARK: - Private Property(ies).

    private static var baseURL: URL { URL(string: "https://wwww.google-analytics.com/connect")! }

    // MARK: - Public Function(s).

    /// Build a GET / POST request
    static func factory(method: Method = .get, params: Params) -> URLRequest {
        switch method {
        case .get: return get(with: params)
        case .post: return post(with: params)
        }
    }

    // MARK: - Private Function(s).

    private static func get(with params: Params) -> URLRequest {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        components.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)") }

        var request = URLRequest(url: components.url!, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 1000)
        request.httpMethod = Method.get.rawValue
        request.addValue(UserAgent.mozilla.value, forHTTPHeaderField: "User-Agent")

        return request
    }

    private static func post(with params: Params) -> URLRequest {
        var request = URLRequest(url: baseURL, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 2000)
        request.httpBody = params.percentEncoded()
        request.httpMethod = Method.post.rawValue
        request.addValue(UserAgent.mozilla.value, forHTTPHeaderField: "User-Agent")

        return request
    }
}

#endif
