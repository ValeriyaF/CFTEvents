import UIKit

class EventsService {
    
    private let imageCache = NSCache<NSString, UIImage>()
    private static var imageURLs = Array<String>()
//    private  var loadedImage: UIImage?
    private static var eventsList: EventsApiResponse = []
    
     var networkManager: NetworkManager?
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getData(completion: @escaping (_ data: EventsApiResponse) -> ()) {
        self.networkManager?.getEvents { [weak self] (data, error) in // self or static ???
            EventsService.imageURLs = data?.compactMap { String($0.cardImage ?? "") } ?? [""]
            completion(data)
        }
//        self.networkManager?.getEvents(completion: completion)
//        guard let url = URL(string: "https://team.cft.ru/api/v1/Events/registration") else {
//            print("URL problem")
//            return
//        }
//        loadData(withURL: url, completion: { [weak self] result in
//            self?.imageCache = ..
//            // save
//            completion(result)
//        })
    }
    
    func getImage(for index: Int, completion: @escaping (_ image: UIImage?, _ url: URL) -> ()) {

        
        let url = URL(string: ("https://team.cft.ru" + EventsService.imageURLs[index]))! // if le
        if let image = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(image, url)
        } else {
            loadImage(withURL: url, completion: completion)
        }
    }

    private func loadData(withURL url:URL, completion: @escaping (_ data: EventsApiResponse) -> ()) {

        let dataTask = URLSession.shared.dataTask(with: url) { (data, responseURL, error) in
            var loadedData: EventsApiResponse?

            if let error = error {
                print("responseURL = \(error.localizedDescription)")
                return
            }

            if let data = data {
                do {
                    loadedData = try JSONDecoder().decode(EventsApiResponse.self, from: data)
                } catch let err {
                    print("Err", err)
                }
            }
            
            if let loadedData = loadedData {
                EventsService.imageURLs = loadedData?.compactMap { String($0.cardImage ?? "") } ?? [""]

            }
            
            DispatchQueue.global(qos: .userInteractive).async {
                completion(loadedData!)
            }
        }
        dataTask.resume()
    }
    
    private func loadImage(withURL url:URL, completion: @escaping (_ image: UIImage?, _ url: URL)->()) {
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, responseURL, error) in
            var loadedImage: UIImage?
            if let data = data {
                loadedImage = UIImage(data: data)
            }
            
            if let loadedImage = loadedImage {
                self?.imageCache.setObject(loadedImage, forKey: url.absoluteString as NSString)
            }
            
            DispatchQueue.global(qos: .userInteractive).async {
                completion(loadedImage, url)
            }
            
        }
        
        dataTask.resume()
    }
}

