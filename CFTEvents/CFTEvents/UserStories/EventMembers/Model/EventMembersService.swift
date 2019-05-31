import Foundation

struct ConfirmationApiResponse: Codable {
    let id: Int
    let isVisited: Bool
    let visitedDate: String
}

class EventMembersService {
    
    private let networkManager: NetworkManager?
    private var membersList: EventMembersApiResponse?
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func confirmMembersVisit(withEventId eventId: Int, memderId: Int,  memberState: Bool, completion: @escaping (_ error: Error?) -> ()) {
        let data = ConfirmationApiResponse(id: memderId, isVisited: memberState, visitedDate: getCurrentDate())
 
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
            DispatchQueue.global(qos: .userInteractive).async {
                completion(error)
            }
        }.resume()
        
    }
    
    func loadMembersList(withEventId id: Int, completion: @escaping (_ data: EventMembersApiResponse) -> ()) {
        networkManager?.getMembers(forEvent: id, completion: { [weak self] data, error in
            if let data = data {
                DispatchQueue.global(qos: .userInitiated).async {
                    completion(data)
                }
            } else {
                print(error)
            }

        })
    }
    
    private func getCurrentDate() -> String {
        let date = Foundation.Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS"
        return formatter.string(from: date)
    }
    
}
