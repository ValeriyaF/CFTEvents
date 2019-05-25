import Foundation

struct ConfirmationApiResponse: Codable {
    let id: Int
    let isVisited: Bool
    let visitedDate: String
}

class EventMembersService {
    private var membersList: EventMembersApiResponse?
    
    func confirmMembersVisit(withEventId eventId: Int, memderId memderId: Int, memberState memberState: Bool, completion: @escaping (_ error: String) -> ()) {
        let data = ConfirmationApiResponse(id: memderId, isVisited: memberState, visitedDate: "2019-05-25T01:54:58.1100")
 
           let httpBody = try! JSONEncoder().encode([data])

        
        guard let url = URL(string: "https://team.cft.ru/api/v1/registration/members/event/\(eventId)/confirmation?token=\(AppConfig.testToken)") else {
            print("url error")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            print(error ?? 0)
            print(data ?? 0)
            
        }.resume()
        
    }
    
    func loadMembersList(withEventId id: Int, completion: @escaping (_ data: EventMembersApiResponse) -> ()) {
        var loadedData: EventMembersApiResponse?
        let url = URL(string: "https://team.cft.ru/api/v1/registration/members/event/\(id)?token=\(AppConfig.testToken)")!
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, responseURL, error) in
            if let error = error {
                print("responseURL = \(error.localizedDescription)")
                return
            }
            if let data = data {
                do {
                    loadedData = try JSONDecoder().decode(EventMembersApiResponse.self, from: data)
                } catch let err {
                    print("Err", err)
                }
            }
            
            DispatchQueue.global(qos: .userInteractive).async {
                completion(loadedData!)
            }
        }
        
        dataTask.resume()
    }
    
    private func getCurrentDate() -> String {
        let date = Foundation.Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS"
        return formatter.string(from: date)
    }
}
