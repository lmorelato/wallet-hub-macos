import Foundation

public class RandomUtils {
    
    /*
     * Generates a random number
     */
    static func random(digits:Int) -> Int {
        let min = Int(pow(Double(10), Double(digits-1))) - 1;
        let max = Int(pow(Double(10), Double(digits))) - 1;
        let range : CountableClosedRange<Int> = min...max;
        return Int(range);
    }
}
