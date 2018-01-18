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
      
        do{
        
            let rq = try self.prepareURLRequest(for: request)

            Alamofire.request(rq)
                .validate()
                .responseJSON { (response) in
                    if response.result.isSuccess{
                        completionHandler(NetworkResponse((r: response.response, data: response.data, error: nil)))
                    } else {
                        
                        completionHandler(NetworkResponse((r: response.response, data: nil, error: response.result.error)))
                    }
            }
        } catch {
            print(error)
//            completionHandler(NetworkResponse()
        }
       
    }
    
    private func prepareURLRequest(for request: Request) throws -> URLRequest {
       
        // Create URL
        let full_url = "\(environment.host)\(request.path)"
        var url_request = URLRequest(url: URL(string: full_url)!)

        if let p = request.parameters {
            url_request.httpBody = try JSONSerialization.data(withJSONObject: p, options: .init(rawValue: 0))
        }
        // Populate the body as JSON
        
        // Add auth headers if they are needed
        if request.needsAuthHeader{
            environment.authHeaders.forEach { url_request.addValue($0.value, forHTTPHeaderField: $0.key) }
        }
        
        // Add request headers
        request.headers?.forEach { url_request.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        // Set http method
        url_request.httpMethod = getMethod(httpCase: request.method).rawValue
        
// Here for debugging
//        print("parameters!!   \(request.parameters)")
//        print("parameters!!   \(try JSONSerialization.data(withJSONObject: request.parameters, options: .init(rawValue: 0)))")
//        print("url!!   \(full_url)")
//        print("method!!   \(request.method)")
//        print("headers!!   \(request.headers)")
        
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
