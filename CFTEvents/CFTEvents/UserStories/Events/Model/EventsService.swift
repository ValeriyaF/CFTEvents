import UIKit

class EventsService {
    
    private var networkManager: NetworkManager?
    private let imageCache = NSCache<NSString, UIImage>()
    private var imageURLs: [String] = []
    private static var eventsList: EventsApiResponse = []
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getData(completion: @escaping (_ data: EventsApiResponse) -> ()) {
        self.networkManager?.getEvents { [weak self] (data, error) in // self or static ???
            self?.imageURLs = data?.compactMap { String($0.cardImage ?? "") } ?? [""]
            completion(data)
        }
    }
    
    func getCurrentImageUrl(for index: Int) -> URL? {
        return URL(string: ("https://team.cft.ru" + imageURLs[index]))
    }
   
}

