import UIKit

// network layer in progress

typealias Events = [Event]?

struct Event: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let cities: [City?]
    let cardImage: String?
    let date: Date?
}

struct City: Codable {
    let nameEng: String?
}

struct Date: Codable {
    let start: String?
    let end: String?
}

class EventsModel {

    private func loadData(withURL url:URL, completion: @escaping (_ data: Events, _ url: URL)->()) {

        let dataTask = URLSession.shared.dataTask(with: url) { (data, responseURL, error) in
            var loadedData: Events?

            if let error = error {
                print("responseURL = \(error.localizedDescription)")
                return
            }

            if let data = data {
                do {
                    loadedData = try JSONDecoder().decode(Events.self, from: data)
                } catch let err {
                    print("Err", err)
                }
            }
            
            DispatchQueue.global(qos: .userInteractive).async {
                completion(loadedData!, url)
            }
        }
        dataTask.resume()
    }

    func getData(completion: @escaping (_ data: Events, _ url: URL)->()) {
        guard let url = URL(string: "https://team.cft.ru/api/v1/Events/registration") else {
            print("URL problem")
            return
        }
        loadData(withURL: url, completion: completion)
    }
}

