import UIKit

class MemberInfoPopupViewController: UIViewController {
    
    private let testView = UIView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        self.view.addSubview(testView)
        
        testView.backgroundColor = .red
        
        configureView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        testView.snp.makeConstraints { (make) in
            make.right.left.top.bottom.equalToSuperview().offset(100)
        }
    }
    
    private func configureView() {
        let action = #selector(tapOnBG)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: action)
        self.view.addGestureRecognizer(gestureRecognizer)
    }
    
    @IBAction func tapOnBG() {
        self.dismiss(animated: true, completion: nil)
    }
}
