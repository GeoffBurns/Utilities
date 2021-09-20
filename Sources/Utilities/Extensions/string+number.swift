//
//  string+isNumber.swift 
//
//  Created by Geoff Burns on 17/9/21.
//

import Foundation

extension String  {
    public var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits
                                                .inverted) == nil
    }
    public var isNumberWithCommas: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits
                                                .union(CharacterSet(charactersIn:","))
                                                .inverted) == nil
    }
    public func measure(unit:Unit) -> String {
        
        let numberWithoutCommas = replacingOccurrences(of: ",", with: "")
        let numberInDouble = Double(numberWithoutCommas)
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .naturalScale
        return numberInDouble == nil
            ? self :
            formatter.string(from: Measurement(value: numberInDouble!, unit: unit) )}
    
}
