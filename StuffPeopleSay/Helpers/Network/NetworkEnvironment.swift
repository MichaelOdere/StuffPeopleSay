import Foundation

public struct NetworkEnvironment {
    
    // Token and Socket Id will be nil until the user is logged in and/or the existing token is verified
    public var host: String
    public var token: String
    public var socketId: String
    public var authHeaders: [String:String] {
        return ["Authorization": token, "SocketId": socketId]
    }
    
    // Cache policy
//    public var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData

    public init(host: String, token: String, socketId:String) {
        self.host = host
        self.token = token
        self.socketId = socketId
    }
    
}

public protocol Dispatcher {
    init(environment: NetworkEnvironment)
    func execute(request: Request, completionHandler: @escaping (NetworkResponse)->Void)
}
