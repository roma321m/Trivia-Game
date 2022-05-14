import UIKit

class ViewController: UIViewController {
    
    let API_PASTE_KEY = "ECxsa7rE"
    let URL_PREFIX = "https://pastebin.com/raw/"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let completetUrl = "\(URL_PREFIX)\(API_PASTE_KEY)"

        let dataManager: DataManager = DataManager()
        dataManager.fetchFromServer(url: completetUrl, delegate: self)
    }
}

extension ViewController: CallBack_Data {
    func gotData(model: MyData) {
        if let d = model.allAnswers{
            print(d.all)
        }
        if let d = model.allQuastions{
            print(d)
        }
    }
}

