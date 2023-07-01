import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var enemySenderbubleView: UIView!
    @IBOutlet weak var enemeMessageText: UILabel!
    
    @IBOutlet weak var MyMessageBubleView: UIView!
    
    @IBOutlet weak var myMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        enemySenderbubleView.layer.cornerRadius = enemySenderbubleView.frame.size.height / 10
        MyMessageBubleView.layer.cornerRadius = MyMessageBubleView.frame.size.height / 10
    }
}
