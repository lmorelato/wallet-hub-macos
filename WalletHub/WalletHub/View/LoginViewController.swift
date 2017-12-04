import Cocoa

class LoginViewController: NSViewController {
    
    @IBOutlet weak var txtEmailLogin: NSTextField!
    @IBOutlet weak var txtPinNumber: NSSecureTextField!
    
    @IBOutlet weak var txtName: NSTextField!
    @IBOutlet weak var txtEmailRegister: NSTextField!
    @IBOutlet weak var cmbCountry: NSComboBox!
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet { }
    }

    @IBAction func btnRegisterClicked(_ sender: Any) {
        let email : String = txtEmailRegister.stringValue.trimmingCharacters(in: .whitespacesAndNewlines);
        let name : String  = txtName.stringValue.trimmingCharacters(in: .whitespacesAndNewlines);
        let country : String  = cmbCountry.stringValue.trimmingCharacters(in: .whitespacesAndNewlines);
        
        if email == "" || name == "" || country == ""
        {
            FormUtils.showAlert(text: "Please, fill in all fields!")
            return;
        }
        
        if !ValidationUtils.isValidEmail(testStr: email)
        {
            FormUtils.showAlert(text: "Invalid email!")
            return;
        }
        
        let pin : Int = RandomUtils.random(digits: 4)
        if FileUtils.register(username: email, password: CryptoUtils.sha256(message: String(pin)))
        {
            FormUtils.showAlert(text: "Registered successfully, your New Pin Number is \(pin), please keep it safe and do not lose it!")
        }
    }
    
    
    @IBAction func btnLoginClicked(_ sender: Any) {
        let email : String = txtEmailLogin.stringValue.trimmingCharacters(in: .whitespacesAndNewlines);
        let pin : String  = txtPinNumber.stringValue.trimmingCharacters(in: .whitespacesAndNewlines);
        
        if email == "" || pin == ""
        {
            FormUtils.showAlert(text: "Please, fill in all fields!")
            return;
        }
        
        if !ValidationUtils.isValidEmail(testStr: email)
        {
            FormUtils.showAlert(text: "Invalid email!")
            return;
        }
        
        if FileUtils.login(username: txtEmailLogin.stringValue, password: CryptoUtils.sha256(message: txtPinNumber.stringValue))
        {
            self.performSegue(withIdentifier: NSStoryboardSegue.Identifier(rawValue: "segueAccountList"), sender: nil)
            self.view.window?.close()
        }
    }
    
}

