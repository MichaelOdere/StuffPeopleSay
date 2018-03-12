// Much of the network layer structure modeled after Network Layers in Swift by Daniele Margutti.
// Source: https://medium.com/@danielemargutti/network-layers-in-swift-7fc5628ff789

public protocol Request {
    var path: String { get }
    var method: HTTPMethodCase { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
    var needsAuthHeader: Bool { get }
}

public enum HTTPMethodCase {
    case post
    case put
    case get
    case delete
}
