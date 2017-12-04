import Foundation

extension Int {
    init(_ range: CountableClosedRange<Int>) {
        let delta = range.lowerBound < 0 ? abs(range.lowerBound) : 0
        let min = UInt32(range.lowerBound + delta)
        let max = UInt32(range.upperBound  + delta)
        self.init(Int(min + arc4random_uniform(max - min)) - delta)
    }
}
