import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var home_LBL_score: UILabel!
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        home_LBL_score.text = "Last Score: \(score)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination as? GameViewController
    }
    
    @IBAction func home_BTN_start(_ sender: Any) {
        performSegue(withIdentifier: "game", sender: sender)
    }
}
