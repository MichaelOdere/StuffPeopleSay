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
        var parameters:[String:Any] = [:]

        if request.needsAuthHeader {
            headers = environment.authHeaders
        }
        
        if let requestHeaders = request.headers{
            for (key,val) in requestHeaders {
                headers[key] = val
            }
        }
        
        if let p = request.parameters {
            parameters = p
        }

        let method:HTTPMethod = getMethod(httpCase: request.method)
        print("parameters!!   \(parameters)")
        Alamofire.request(url,
                          method: method,
                          parameters: parameters,
                          encoding: URLEncoding.httpBody,
                          headers:headers)
        .validate()
        .responseData { (response) in
            if response.result.isSuccess{
                completionHandler(NetworkResponse((r: response.response, data: response.data, error: nil)))
            } else {
                print("Error while fetching: \(String(describing: response.result.error))")
                print("url!!   \(url)")
                print("method!!   \(method)")
                print("headers!!   \(headers)")
                completionHandler(NetworkResponse((r: response.response, data: nil, error: response.result.error)))
            }
        }
    }
    
    public func prepareURLRequest(for request: Request) throws -> URLRequest {
        // Compose the url
        let full_url = "\(environment.host)\(request.path)"
        var url_request = URLRequest(url: URL(string: full_url)!)
        // Parameters are part of the body
        url_request.httpBody = try JSONSerialization.data(withJSONObject: request.parameters, options: .init(rawValue: 0))
   
        print("body \(url_request.httpBody)")
        // Add headers from enviornment and request
        environment.authHeaders.forEach { url_request.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
        request.headers?.forEach { url_request.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
        
        // Setup HTTP method
        url_request.httpMethod = getMethod(httpCase: request.method).rawValue
        
//        return url_request
        
        Alamofire.request(url_request).responseJSON { (response) in
            print(response)
        }
        
        return url_request
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
