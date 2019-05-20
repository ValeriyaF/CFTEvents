import UIKit

// network layer in progress

typealias Response = [Event]?

struct Event: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let cities: [City?]?
    let cardImage: String?
    let date: Date?
    
    init(id: Int? = nil, title: String? = nil, description: String? = nil,
         cities: [City?]? = nil, cardImage: String? = nil, date: Date? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.cities = cities
        self.cardImage = cardImage
        self.date = date
    }

}

struct City: Codable {
    let nameEng: String?
}

struct Date: Codable {
    let start: String?
    let end: String?
}

class EventsModel {
    
    private let cache = NSCache<NSString, UIImage>()
    private var imageURLs = Array<String>()

    private func loadData(withURL url:URL, completion: @escaping (_ data: Response, _ url: URL)->()) {

        let dataTask = URLSession.shared.dataTask(with: url) { (data, responseURL, error) in
            var loadedData: Response?
            self.cache.removeAllObjects()

            if let error = error {
                print("responseURL = \(error.localizedDescription)")
                return
            }

            if let data = data {
                do {
                    loadedData = try JSONDecoder().decode(Response.self, from: data)
                } catch let err {
                    print("Err", err)
                }
            }
            
            if let loadedData = loadedData {
                self.imageURLs = loadedData?.compactMap { String($0.cardImage ?? "") } ?? [""]
            }
            
            DispatchQueue.global(qos: .userInteractive).async {
                completion(loadedData!, url)
            }
        }
        dataTask.resume()
    }
    
    private func loadImage(withURL url:URL, completion: @escaping (_ image: UIImage?, _ url: URL)->()) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, responseURL, error) in
            var loadedImage:UIImage?
            
            if let data = data {
                loadedImage = UIImage(data: data)
            }
            
            if let loadedImage = loadedImage {
                self.cache.setObject(loadedImage, forKey: url.absoluteString as NSString)
            }
            
            DispatchQueue.global(qos: .userInteractive).async {
                completion(loadedImage, url)
            }
            
        }
        
        dataTask.resume()
    }

    func getData(completion: @escaping (_ data: Response, _ url: URL)->()) {
        guard let url = URL(string: "https://team.cft.ru/api/v1/Events/registration") else {
            print("URL problem")
            return
        }
        loadData(withURL: url, completion: completion)
    }
    
    func getImage(for indexPath: IndexPath, completion: @escaping (_ image: UIImage?, _ url: URL) -> () ) {
//        let index = imageURLs[indexPath.row]
        let url = URL(string: "https://team.cft.ru" + imageURLs[indexPath.row])! // if let
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            completion(image, url)
        } else {
            loadImage(withURL: url, completion: completion)
        }
    }
}

