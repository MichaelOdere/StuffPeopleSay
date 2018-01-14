import Foundation

public struct Environment {
    
    // Token and Socket Id will be nil until the user is logged in and/or the existing token is verified
    public var host: String
    public var token: String?
    public var socketId: String?
    public var authHeaders: [String:String]? {
        if let t = token, let s = socketId{
            return ["Authorization": t, "SocketId": s]
        }
        return nil
    }
    
    // Cache policy
//    public var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData

    public init(host: String) {
        self.host = host
    }
}

public protocol Dispatcher {
    init(environment: Environment)
    func execute(request: Request, completionHandler: (Data, Error)->Void)
}
