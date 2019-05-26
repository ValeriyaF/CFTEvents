import Foundation

enum EventApi {
    case events
    case members(eventId: Int)
}

extension EventApi: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "https://team.cft.ru/") else { //https://team.cft.ru/api/v1/registration/members/event/\(eventId)/confirmation?token=\(AppConfig.testToken)
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .events:
            return "api/v1/Events/registration"
        case .members(let eventId):
            return "api/v1/registration/members/event/\(eventId)" //?token=\(AppConfig.testToken)" // right way add token?
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get // add post
    }
    
    var task: HTTPTask {
        switch self {
        case .members(let eventId):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["token":AppConfig.testToken])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}
