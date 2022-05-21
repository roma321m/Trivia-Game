import UIKit

class ViewController: UIViewController {
    
    let API_PASTE_KEY = "deauiqcc"
    let URL_PREFIX = "https://pastebin.com/raw/"

    @IBOutlet weak var main_BTN_a2: UIButton!
    @IBOutlet weak var main_BTN_a1: UIButton!
    @IBOutlet weak var main_BTN_a3: UIButton!
    @IBOutlet weak var main_BTN_a4: UIButton!
    @IBOutlet weak var main_IMG_q: UIImageView!
    @IBOutlet weak var main_IMG_heart3: UIImageView!
    @IBOutlet weak var main_IMG_heart2: UIImageView!
    @IBOutlet weak var main_IMG_heart1: UIImageView!
    @IBOutlet weak var main_LBL_progress: UILabel!
    @IBOutlet weak var main_PB_progress: UIProgressView!
    
    var dataManager:DataManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let completetUrl = "\(URL_PREFIX)\(API_PASTE_KEY)"

        dataManager = DataManager()
        dataManager.fetchFromServer(url: completetUrl, delegate: self)
    }
    
    
    @IBAction func a1Clicked(_ sender: Any) {
        setNextQ()
    }
    
    
    @IBAction func a2Clicked(_ sender: Any) {
        
    }
    
    @IBAction func a3Clicked(_ sender: Any) {
        
    }
    
    @IBAction func a4Clicked(_ sender: Any) {
        
    }
}

extension ViewController: CallBack_Data {
    func gotData(model: MyData) {
        dataManager.setData(data: model)
        setNextQ()
    }
    
    func setNextQ(){
        let q = dataManager.getNextQ()
        let answers = dataManager.getRandomA(q: q.answer ?? "")
        main_IMG_q.loadFrom(URLAddress: q.imageUrl ?? "")
        main_BTN_a1.setTitle(answers[0], for: .normal)
        main_BTN_a2.setTitle(answers[1], for: .normal)
        main_BTN_a3.setTitle(answers[2], for: .normal)
        main_BTN_a4.setTitle(answers[3], for: .normal)
        main_PB_progress.progress = Float(dataManager.qCount)/15.0
        main_LBL_progress.text = "\(dataManager.qCount)/15"
    }
        
}

