//import Foundation
//
//protocol EndPointType {
//    var baseURL: URL { get }
//    var path: String { get }
//    var httpMethod: HTTPMethod { get }
//    var task: HTTPTask { get }
//    var headers: HTTPHeaders? { get }
//}
//
//public enum HTTPMethod : String {
//    case get     = "GET"
//    case post    = "POST"
////    case put     = "PUT"
////    case patch   = "PATCH"
////    case delete  = "DELETE"
//}
//
//public typealias HTTPHeaders = [String:String]
//
//public enum HTTPTask {
//    case request
//    
////    case requestParameters(bodyParameters: Parameters?,
////        bodyEncoding: ParameterEncoding,
////        urlParameters: Parameters?)
////
////    case requestParametersAndHeaders(bodyParameters: Parameters?,
////        bodyEncoding: ParameterEncoding,
////        urlParameters: Parameters?,
////        additionHeaders: HTTPHeaders?)
//    
//    // case download, upload...etc
//}
//
//
//public enum EventsApi {
//    case events
//    //    case recommended(id:Int)
//    //    case popular(page:Int)
//    //    case newMovies(page:Int)
//    //    case video(id:Int)
//}
//
//extension EventsApi: EndPointType {
//    var baseURL: URL {
//        guard let url = URL(string: "https://team.cft.ru/api/v1") else { fatalError("baseURL could not be configured.")}
//        return url
//    }
//    
//    var path: String {
//        switch self {
//        case .events:
//            return "/Events/registration" // need to fix
//        }
//    }
//    
//    var httpMethod: HTTPMethod {
//        return .get
//    }
//    
//    var task: HTTPTask {
//        return .request
//
//    }
//    
//    var headers: HTTPHeaders? {
//        return nil
//    }
//    
//    
//}
//
//
