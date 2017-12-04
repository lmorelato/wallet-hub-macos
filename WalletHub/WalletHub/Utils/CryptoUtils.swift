import Foundation
import CryptoSwift


public class CryptoUtils {
    
    /*
     * Applies SHA256 hash
     */
    static func sha256(message : String) -> String
    {
        return message.sha256();
    }
}
