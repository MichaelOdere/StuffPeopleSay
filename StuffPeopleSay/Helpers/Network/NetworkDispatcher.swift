import Alamofire


public enum NetworkErrors: Error {
    case unauthorized
    case noData
}

public class NetworkDispatcher: Dispatcher {
    
    private var environment: NetworkEnvironment

    required public init(environment: NetworkEnvironment) {
        self.environment = environment
    }

    public func execute(request: Request) -> NetworkResponse {
        let full_url = "\(environment.host)/\(request.path)"
        let url = URL(string: full_url)!
        
        var headers:[String:String] = [:]
        
        if request.needsAuthHeader {
            headers = environment.authHeaders
        }
        
        if let requestHeaders = request.headers{
            for (key,val) in requestHeaders {
                headers[key] = val
            }
        }
        
        var networkResponse:NetworkResponse!
        
        let method:HTTPMethod = getMethod(httpCase: request.method)
        Alamofire.request(url,
                          method: method,
                          parameters: request.parameters,
                          headers:headers)
        .validate()
        .responseData { (response) in
            if response.result.isSuccess{
                networkResponse = NetworkResponse((r: response.response, data: response.data, error: nil))
            } else {
                print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                networkResponse = NetworkResponse((r: response.response, data: nil, error: response.result.error))
            }
        }
        
        return networkResponse
    }
    
    func getMethod(httpCase: HTTPMethodCase) -> HTTPMethod {
        switch httpCase{
        case .post:
            return .post
        case .put:
            return .put
        case .get:
            return .get
        case .delete:
            return .delete
        }
    }
    
}
