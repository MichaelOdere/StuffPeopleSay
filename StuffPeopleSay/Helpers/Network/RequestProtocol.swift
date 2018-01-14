public protocol Request {
    var path:       String            { get }
    var method:     HTTPMethod        { get }
    var headers:    [String: String]? { get }
}

public enum HTTPMethod: String {
    case post   = "POST"
    case put    = "PUT"
    case get    = "GET"
    case delete = "DELETE"
}

