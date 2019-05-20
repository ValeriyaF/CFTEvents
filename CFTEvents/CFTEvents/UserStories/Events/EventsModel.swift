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
    
    private let imageCache = NSCache<NSString, UIImage>()
    private static var imageURLs = Array<String>()
    private var loadedImage:UIImage?
    
    func getData(completion: @escaping (_ data: Response, _ url: URL)->()) {
        guard let url = URL(string: "https://team.cft.ru/api/v1/Events/registration") else {
            print("URL problem")
            return
        }
        loadData(withURL: url, completion: completion)
    }
    
    func getImage(for index: Int, completion: @escaping (_ image: UIImage?, _ url: URL) -> () ) {
        let url = URL(string: "https://team.cft.ru" + EventsModel.imageURLs[index])! // if let
        if let image = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(image, url)
        } else {
            loadImage(withURL: url, completion: completion)
        }
    }

    private func loadData(withURL url:URL, completion: @escaping (_ data: Response, _ url: URL)->()) {

        let dataTask = URLSession.shared.dataTask(with: url) { (data, responseURL, error) in
            var loadedData: Response?
//            self.imageCache.removeAllObjects()
//            self.loadedImage = nil

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
                EventsModel.imageURLs = loadedData?.compactMap { String($0.cardImage ?? "") } ?? [""]

            }
            
            DispatchQueue.global(qos: .userInteractive).async {
                completion(loadedData!, url)
            }
        }
        dataTask.resume()
    }
    
    private func loadImage(withURL url:URL, completion: @escaping (_ image: UIImage?, _ url: URL)->()) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, responseURL, error) in
            
            if let data = data {
                self.loadedImage = UIImage(data: data)
            }
            
            if let loadedImage = self.loadedImage {
                self.imageCache.setObject(loadedImage, forKey: url.absoluteString as NSString)
            }
            
            DispatchQueue.global(qos: .userInteractive).async {
                completion(self.loadedImage, url)
            }
            
        }
        
        dataTask.resume()
    }
}

