import Foundation

public class CurrencyUtils {
    
    /*
     * Gets the currency factor between to currencies
     */
    static func getFactor(from: String, to: String) -> Double {
        var factor : Double = 1;
        
        if (from == "BRL"){
            switch to {
            case "CAD":
                factor = 0.394238;
                break;
            case "UAH":
                factor = 8.26686;
                break;
            case "USD":
                factor = 0.304952;
                break;
            default:
                break;
            }
        }
        if (from == "CAD"){
            switch to {
            case "BRL":
                factor = 2.53723;
                break;
            case "UAH":
                factor = 20.9660;
                break;
            case "USD":
                factor = 0.774916;
                break;
            default:
                break;
            }
        }
        if (from == "UAH"){
            switch to {
            case "BRL":
                factor = 0.121048;
                break;
            case "CAD":
                factor = 0.0477007;
                break;
            case "USD":
                factor = 0.0369849;
                break;
            default:
                break;
            }
        }
        if (from == "USD"){
            switch to {
            case "BRL":
                factor = 3.27849;
                break;
            case "CAD":
                factor = 1.29004;
                break;
            case "UAH":
                factor = 27.0127;
                break;
            default:
                break;
            }
        }
        
        return factor;
    }
}
