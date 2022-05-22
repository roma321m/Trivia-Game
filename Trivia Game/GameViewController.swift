import UIKit

class GameViewController: UIViewController {
    
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
        checkAnswer(a: 1, sender: sender)
    }
    
    
    @IBAction func a2Clicked(_ sender: Any) {
        checkAnswer(a: 2, sender: sender)
    }
    
    @IBAction func a3Clicked(_ sender: Any) {
        checkAnswer(a: 3, sender: sender)
    }
    
    @IBAction func a4Clicked(_ sender: Any) {
        checkAnswer(a: 4, sender: sender)
    }
}

extension GameViewController: CallBack_Data {
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
    
    func checkAnswer(a:Int, sender: Any){
        if let a1 = dataManager.data?.allQuastions?[dataManager.qCount-1].answer {
            print("should be: \(a1)")
            switch a {
            case 1:
                print("actual: \(String(describing: main_BTN_a1.titleLabel?.text))")
                if (a1 == main_BTN_a1.titleLabel?.text){
                    dataManager.addScore()
                }else{
                    let b = dataManager.removeHeart()
                    if (b){
                        finishGame(sender: sender)
                    }
                    else{
                        checkHearts()
                    }
                }
                if (dataManager.qCount == 15){
                    finishGame(sender: sender)
                }else{
                    setNextQ()
                }
            case 2:
                print("actual: \(String(describing: main_BTN_a2.titleLabel?.text))")
                if (a1 == main_BTN_a2.titleLabel?.text){
                    dataManager.addScore()
                }else{
                    let b = dataManager.removeHeart()
                    if (b){
                        finishGame(sender: sender)
                    }
                    else{
                        checkHearts()
                    }
                }
                if (dataManager.qCount == 15){
                    finishGame(sender: sender)
                }else{
                    setNextQ()
                }
            case 3:
                print("actual: \(String(describing: main_BTN_a3.titleLabel?.text))")
                if (a1 == main_BTN_a3.titleLabel?.text){
                    dataManager.addScore()
                }else{
                    let b = dataManager.removeHeart()
                    if (b){
                        finishGame(sender: sender)
                    }
                    else{
                        checkHearts()
                    }
                }
                if (dataManager.qCount == 15){
                    finishGame(sender: sender)
                }else{
                    setNextQ()
                }
            case 4:
                print("actual: \(String(describing: main_BTN_a4.titleLabel?.text))")
                if (a1 == main_BTN_a4.titleLabel?.text){
                    dataManager.addScore()
                }else{
                    let b = dataManager.removeHeart()
                    if (b){
                        finishGame(sender: sender)
                    }
                    else{
                        checkHearts()
                    }
                }
                if (dataManager.qCount == 15){
                    finishGame(sender: sender)
                }else{
                    setNextQ()
                }
            default:
                return
            }
            print(dataManager.qCount)
            print(dataManager.score)
            print(dataManager.hearts)
        }
    }
    
    func checkHearts(){
        let h = dataManager.hearts
        if (h < 3){
            main_IMG_heart3.isHidden = true
        }
        if (h < 2){
            main_IMG_heart2.isHidden = true
        }
        if (h < 1){
            main_IMG_heart1.isHidden = true
        }
    }
    
    func finishGame(sender: Any){
        performSegue(withIdentifier: "home", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let homeView=segue.destination as? HomeViewController {
            homeView.score = dataManager.score
        }
    }
}

