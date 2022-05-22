import Foundation


protocol CallBack_Data {
    func gotData(model: MyData)
}

protocol qaManager {
    func getNextQ() -> Quastion
    func getRandomA(q: String) -> [String]
    func findIndex(q: String) -> Int
    func getIndex(index: Int) -> [Int]
    func getQuestionCount() -> Int
}

protocol scoreManager {
    func addScore()
    func removeHeart() -> Bool
}

class DataManager {
    
    var delegate: CallBack_Data?
    var data: MyData?
    var qCount = 0
    var score = 0
    var hearts = 3
    
    func setData(data: MyData?){
        if let d = data {
            self.data = d
        }
    }
    
    func fetchFromServer(url: String, delegate: CallBack_Data) {
        self.delegate = delegate
        performRequest(fullUrl: url)
    }
    
    func performRequest(fullUrl: String) {
        if let url: URL = URL(string: fullUrl) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, urlResponse, error) in
                if let e = error {
                    print("error:\(e)")
                    return
                }
                
                if let safeData = data {
                    let dataString = String(data: safeData, encoding: .utf8)
                    print("dataString:\(dataString!)")
                    self.parseJSON(data: safeData)
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(data: Data) {
        let decoder = JSONDecoder()
        
        do {
            let model = try decoder.decode(MyData.self, from: data)
            
            DispatchQueue.main.sync {
                self.delegate?.gotData(model: model)
            }
            
        } catch {
            print("Error: \(error)")
        }
    }
}

extension DataManager : qaManager {
    
    func getQuestionCount() -> Int {
        return qCount
    }
    
    func getNextQ() -> Quastion {
        if let q = self.data?.allQuastions?[qCount]{
            qCount += 1;
            return q
        }
        return Quastion()
    }
    
    func getRandomA(q: String) -> [String]{
        var res: [String] = ["","","",""]
        if let all = data?.allAnswers?.all{
            let index: [Int] = getIndex(index: findIndex(q: q))
            for i in 0...3 {
                res[i] = (all[index[i]])
            }
        }
        
        return res
    }
    
    func findIndex(q: String) -> Int{
        if let index = data?.allAnswers?.all?.firstIndex(of: q) {
            return index
        }
        return -1
    }
    
    func getIndex(index: Int) -> [Int]{
        var res: [Int] = [0,0,0,0]
        if let i = data?.allAnswers?.all?.count {
            
            var indexes :Set<Int> = []
            indexes.insert(index)
            
            for _ in 0...2 {
                var temp = Int.random(in: 0...i-1)
                while (indexes.contains(temp)){
                    temp = Int.random(in: 0...i-1)
                }
                indexes.insert(temp)
            }
            res = Array(indexes)
        }
        return res
    }
}

extension DataManager : scoreManager {
    
    func addScore() {
        score = score + 1
    }
    
    func removeHeart() -> Bool {
        hearts = hearts - 1
        if (hearts < 0) {
            return true
        }
        return false
    }
}
