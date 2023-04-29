import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var detail: SupportResponse.DetailItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailsTableView
    }
}
