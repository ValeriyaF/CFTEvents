import UIKit

class EventsService {
    
    private var networkManager: NetworkManager?
    private let imageCache = NSCache<NSString, UIImage>()
    private static var imageURLs = Array<String>()
    private static var eventsList: EventsApiResponse = []
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getData(completion: @escaping (_ data: EventsApiResponse) -> ()) {
        self.networkManager?.getEvents { (data, error) in // self or static ???
            EventsService.imageURLs = data?.compactMap { String($0.cardImage ?? "") } ?? [""]
            completion(data)
        }
    }
    
    func getCurrentImageUrl(for index: Int) -> URL? {
        if let imageUrl = URL(string: ("https://team.cft.ru" + EventsService.imageURLs[index])) {
            return imageUrl
        } else {
           return nil
        }
        
    }
   
}

