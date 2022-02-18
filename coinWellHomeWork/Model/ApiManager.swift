import Alamofire
final class ApiManager{
    static let instance = ApiManager()
    enum Constans {
        static let baseURL = "https://rest.coinapi.io/v1"
    }
    enum EndPoint {
        static let assets = "/assets"
    }
   private let header: HTTPHeaders = ["X-CoinAPI-Key":
                                "2D5456EB-D37B-4609-A828-04362AD282FA" ,
                               "Accept" : "application/json"]
    func getAllExchanges(complition: @escaping (([CoinClientModel])) -> Void){
        AF.request(Constans.baseURL + EndPoint.assets,
                   method: .get,
                   parameters: [:],
                   headers: header).responseDecodable(of: [CoinServerModel].self){ response in
            switch response.result{
            case .success(let data):
                let converteredModels = data.map(ModelConverter.instance.convert)
                complition(converteredModels)
            case .failure(let error): print(error)
            }
        }
    }
}
