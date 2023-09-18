import UIKit

//MARK: - BaseViewController
class BaseViewController: UIViewController {

    //properties
    var mainScrollView: UIScrollView?
    var tapGesture: (Any)? = nil
    
    //MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        setTapGesturesRemoveable()
    }
    
    func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setTapGesturesRemoveable(){
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    }
    
    //MARK: - @objc
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        var contentInset:UIEdgeInsets = self.mainScrollView?.contentInset ?? UIEdgeInsets.zero
        contentInset.bottom = keyboardFrame.size.height + 20
        mainScrollView?.contentInset = contentInset
        view.addGestureRecognizer(tapGesture as! UIGestureRecognizer)
    }

    @objc func keyboardWillHide(notification:NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        mainScrollView?.contentInset = contentInset
        view.removeGestureRecognizer(tapGesture as! UIGestureRecognizer)
    }
}
