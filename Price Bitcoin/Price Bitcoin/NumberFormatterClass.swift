//
//  NumberFormatter.swift
//  Price Bitcoin
//
//  Created by Jefferson Oliveira de Araujo on 02/10/21.
//

import UIKit
import Foundation

// MARK: Example 1
// MARK: Formatar número com virgula para ponto
class NumberFormatterClass: UIViewController {
    
    override func viewDidLoad() {
        let number = "1.200,15"
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale(identifier: "pt_BR")
        
        if let result = numberFormatter.number(from: number) {
            let resultDouble = Double(result)
            let total = resultDouble + 1
        }
    }
}

// MARK: Example 2
class NumberFormatterClass2: UIViewController {
    
    override func viewDidLoad() {
        let number = NSNumber(value: 1000.20)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
//        numberFormatter.groupingSeparator = "."
//        numberFormatter.decimalSeparator = ","
        numberFormatter.locale = Locale(identifier: "pt_BR")
        
        if let result = numberFormatter.string(from: number) {
            print(result)
        }
    }
}
