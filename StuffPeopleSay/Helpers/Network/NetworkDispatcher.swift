import Alamofire

public class NetworkDispatcher: Dispatcher {
    
    private var environment: Environment

    required public init(environment: Environment) {
        self.environment = environment
    }

    public func execute(request: Request, completionHandler: @escaping (Data?, Error?) -> Void) {
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
        
        let method:HTTPMethod = getMethod(httpCase: request.method)
        Alamofire.request(url,
                          method: method,
                          parameters: request.parameters,
                          headers:headers)
        .validate()
            .responseData { (response) in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(response.result.error)")
                    completionHandler(nil, response.result.error)
                    return
                }
                
                completionHandler(response.data, nil)

            }
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
