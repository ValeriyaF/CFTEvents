import Foundation

enum EventApi {
    case events
    case image
}

extension EventApi: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "https://team.cft.ru/") else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .events:
            return "api/v1/Events/registration"
        case .image:
            return ""
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
