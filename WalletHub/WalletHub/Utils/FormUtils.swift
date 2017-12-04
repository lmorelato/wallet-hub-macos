import Cocoa
import Foundation

public class FormUtils {
    
    static func showAlert(text: String) {
        let alert = NSAlert()
        alert.messageText = "WalletHub"
        alert.informativeText = text
        alert.alertStyle = NSAlert.Style.informational
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
}
