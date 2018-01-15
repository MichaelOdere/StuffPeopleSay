public protocol Request {
    var path:       String               { get }
    var method:     HTTPMethodCase           { get }
    var parameters: [String: Any]?       { get }
    var headers:    [String: String]?    { get }
    var needsAuthHeader: Bool            { get }
}

public enum HTTPMethodCase {
    case post
    case put
    case get
    case delete 
}
