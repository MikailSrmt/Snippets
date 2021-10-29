//Get photo(data) from Flicker by location

import Foundation

class FlickerClient{
    
    enum Endpoints {
        
        static let base = "https://api.flickr.com/services/rest/?method=flickr.photos.search"
        
        case getPhotos(Double, Double)
        case getUrls(String, String, String)
        
        struct Auth {
            static let apikey = "your_api_key"
        }
        
        var stringValue: String{
            
            
            switch self {
            case .getPhotos(let latitude, let longitude): return Endpoints.base + "&api_key=\(Auth.apikey)&lat=\(latitude)&lon=\(longitude)&per_page=20&page=\(Int.random(in: 1...10))&format=json&nojsoncallback=1"
            case .getUrls(let serverId, let id, let secret): return "https://live.staticflickr.com/\(serverId)/\(id)_\(secret).jpg"
            }
            }
            
            var url: URL{
                return URL(string: stringValue)!
            }
        }
    }
    
    @discardableResult class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionTask{
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }

            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
            
        }
        task.resume()
        return task
    }
    
    class func getPhotos(latitude: Double, longitude: Double, completion: @escaping (PhotoResponse?, Error?) -> Void ){
        taskForGETRequest(url: Endpoints.getPhotos(latitude, longitude).url, responseType: PhotoResponse.self) { response, error in
            if let response = response {
                completion(response.self, nil)
                print(response)
            }else {
                completion(nil, error)
            }
        }
    }
    
    class func downloadPhotos(serverId: String, id: String, secret: String, completion: @escaping (Data?, Error?)-> Void){
        
        let task = URLSession.shared.dataTask(with: Endpoints.getUrls(serverId, id, secret).url) { data, response, error in
            DispatchQueue.main.async {
                completion(data, error)
                print("album downloaded")
            }
        }
        task.resume()
    }
}
