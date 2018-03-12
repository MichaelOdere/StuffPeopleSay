// Much of the network layer structure modeled after Network Layers in Swift by Daniele Margutti.
// Source: https://medium.com/@danielemargutti/network-layers-in-swift-7fc5628ff789

import Foundation
import SwiftyJSON

public enum NetworkResponse {
    case json(_: JSON)
    case error(_: Int?, _: Error?)

    init(_ response: (r: HTTPURLResponse?, data: Data?, error: Error?)) {
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
