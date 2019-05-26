import UIKit

class MemberInfoPopupViewController: UIViewController {
    
    var memberInfoViewDidDisappear: (() -> ())? = nil
    private let memberInfoView = UIView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        self.view.addSubview(memberInfoView)
        
        memberInfoView.backgroundColor = .white
        
        configureView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        memberInfoView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view).offset(ViewConstants.membersInfoPopupViewOffset)
            make.height.equalTo(self.view).offset(ViewConstants.membersInfoPopupViewOffset - 130)
            make.center.equalTo(self.view)
        }
        
        memberInfoView.layer.cornerRadius = ViewConstants.viewCornerRadius
    }
    
    private func configureView() {
        let action = #selector(tapOnBG)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: action)
        self.view.addGestureRecognizer(gestureRecognizer)
    }
    
    @IBAction func tapOnBG(_ sender: UIViewController) {
        self.dismiss(animated: true, completion: nil)
        
        if let action = self.memberInfoViewDidDisappear {
            action()
        }
        
    }
}
