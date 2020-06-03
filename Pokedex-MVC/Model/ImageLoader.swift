import UIKit

final class ImageLoader {
    private var cachedImages = [URL : UIImage]()
    private var runningTasks = [UUID: URLSessionDataTask]()
    
    @discardableResult
    func load(from url: URL, completionHandler: @escaping (UIImage?) -> Void) -> UUID? {
        if let image = cachedImages[url] {
            completionHandler(image)
            return nil
        }
        
        let uuid = UUID()
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            defer {
                self.runningTasks.removeValue(forKey: uuid)
            }
            
            if let data = data {
                let image = UIImage(data: data)
                self.cachedImages[url] = image
                
                completionHandler(image)
            }
        }
        
        runningTasks[uuid] = task
        task.resume()
        
        return uuid
    }
    
    func cancel(uuid: UUID) {
        runningTasks[uuid]?.cancel()
        runningTasks.removeValue(forKey: uuid)
    }
    
    
    
//    static func getImage(for url: URL, completed: @escaping (UIImage?, URLSessionDataTask?) -> Void) -> URLSessionDataTask?{
//        if let image = images[url] {
//            completed(image, nil)
//            return nil
//        }
//
//        var task: URLSessionDataTask?
//        ImageLoader.downloadQueue.async {
//            task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
//                ImageCache.updateQueue.async {
//                    guard let data = data else {
//                        completed(nil, nil)
//                        return
//                    }
//
//                    images[url] = UIImage(data: data)
//                    completed(images[url], task)
//                }
//            })
//            task?.resume()
//        }
//
//        return task
//    }
}
