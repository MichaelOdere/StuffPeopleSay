protocol Operation {
    associatedtype Output
    var request: Request { get }
    func execute(in dispatcher: Dispatcher, completionHandler: @escaping (Output?) -> Void)
}
