import Foundation
import SwiftyJSON

public enum NetworkResponse {
    case json(_: JSON)
    case error(_: Int?, _: Error?)
    
    init(_ response: (r: HTTPURLResponse?, data: Data?, error: Error?), for request: Request) {
        guard response.r?.statusCode == 200, response.error == nil else {
            self = .error(response.r?.statusCode, response.error)
            return
        }
        
        guard let data = response.data else {
            self = .error(response.r?.statusCode, NetworkErrors.noData)
            return
        }
        
        do {
            let jsonData = try JSON(data: data)
            self = .json(jsonData)
        } catch  let error as NSError {
            self = .error(response.r?.statusCode, error)
        }
        
    }
}

