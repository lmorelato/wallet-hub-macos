import Foundation

public class FileUtils {
    
    static private let path : String? = Bundle.main.path(forResource: "users", ofType: "txt")
    
    /*
     * Reads the file
     */
    static func readFile() -> [String] {
        let dir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL  = dir.appendingPathComponent("wallethub.txt");
    
        var text : [String]? = nil
        
        do {
            //let data = try String(contentsOfFile: path!, encoding: .utf8)
            let data = try String(contentsOf: fileURL, encoding: .utf8)
            
            print(data)
            text = data.components(separatedBy: ":")
        } catch let error as NSError {
            print(error.localizedDescription)
            FormUtils.showAlert(text: error.localizedDescription)
        }
        return text!
    }
    
    /*
     * Executes login
     */
    static func login(username : String, password : String) -> Bool {
        let text = readFile()
        
        if text.contains(username) {
            if password != text[text.index(of: username)! + 1]
            {
                FormUtils.showAlert(text: "Login/Password Incorrect!");
                return false;
            }
        }
        else {
            FormUtils.showAlert(text: "User not found, please register first!")
            return false;
        }
        
        return true;
    }
    
    /*
     * Register a new user
     */
    static func register(username : String, password : String) -> Bool {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("wallethub.txt");
        
        do {
            let text = readFile()
            let content = text.joined(separator: ":")
            if (text.contains(username))
            {
                FormUtils.showAlert(text: "Login already registered, try a different username!");
                return false;
            }
            
            // Write to the file
            let value : String = "\(content):\(username):\(password)"
            try value.write(to: fileURL!, atomically: true, encoding: String.Encoding.utf8)
                     
        } catch let error as NSError {
            print("Failed writing to URL: \(fileURL!), Error: " + error.localizedDescription)
            FormUtils.showAlert(text: "Failed writing to URL: \(fileURL!), Error: " + error.localizedDescription)
            return false;
        }
        
        return true;
    }
    
}
