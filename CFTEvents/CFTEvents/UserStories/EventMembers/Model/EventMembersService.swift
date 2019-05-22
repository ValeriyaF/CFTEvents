import Foundation

class EventMembersService {
    private var membersList: EventMembersApiResponse?
    
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
    
}
