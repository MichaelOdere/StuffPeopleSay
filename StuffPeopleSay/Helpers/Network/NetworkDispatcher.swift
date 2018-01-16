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

    func setEnvironment(environment: NetworkEnvironment) {
        self.environment = environment
    }
    
    public func execute(request: Request, completionHandler: @escaping (NetworkResponse)->Void) {
        let full_url = "\(environment.host)\(request.path)"
        guard let url = URL(string: full_url) else{
            print("Something went wrong with the URL")
            print(full_url)
            return
        }

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
            if response.result.isSuccess{
                completionHandler(NetworkResponse((r: response.response, data: response.data, error: nil)))
            } else {
                print("Error while fetching: \(String(describing: response.result.error))")
                print("headers!!   \(headers)")
                print("url!!   \(url)")
                print("parameters!!   \(request.parameters)")
                completionHandler(NetworkResponse((r: response.response, data: nil, error: response.result.error)))
            }
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
