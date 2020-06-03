import Foundation

extension URLSession {
    @discardableResult
    func dataTask(with endpoint: Endpoint, completionHandler: @escaping (Result<Data, Error>) -> Void) -> URLSessionTask {
        let task = URLSession.shared.dataTask(with: endpoint.url, completionHandler: { (data, response, error) in
            if let data = data {
                completionHandler(.success(data))
            }
            
            if let error = error {
                completionHandler(.failure(error))
            }
        })
        
        task.resume()
        return task
    }
}
