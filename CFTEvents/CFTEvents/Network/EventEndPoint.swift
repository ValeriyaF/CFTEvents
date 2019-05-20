import Foundation

enum EventApi {
    case events
}

extension EventApi: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "https://team.cft.ru/api/v1/") else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .events:
            return "Events/registration"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get // add post
    }
    
    var task: HTTPTask {
        return .request
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}
