//
//  GrailedCalculatorViewController.swift
//  GrailedCalculator
//
//  Created by Garret Koontz on 10/19/17.
//  Copyright © 2017 GK Inc. All rights reserved.
//

import UIKit

class GrailedCalculatorViewController: UIViewController {

    @IBOutlet weak var listingPriceTextField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var grailedCommissionLabel: UILabel!
    @IBOutlet weak var paypalFeesLabel: UILabel!
    @IBOutlet weak var profitLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func calculateButtonTapped(_ sender: Any) {
        
        guard let convertedPrice = listingPriceTextField.text else { return }
        let price = convertedPrice.doubleValue
        calculate(listingPrice: price)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func calculate(listingPrice: Double) -> Double {
        
        let grailedCommission = 0.06
        let convertedGrailedCommission = listingPrice * grailedCommission
        let newPrice = listingPrice - convertedGrailedCommission
        let paypalFees = (newPrice * 0.029) + 0.30
        let yourProfit = newPrice - paypalFees
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        
        let comm = NSNumber(value: convertedGrailedCommission)
        let fees = NSNumber(value: paypalFees)
        let profit = NSNumber(value: yourProfit)
        
        let newCommission = formatter.string(from: comm)
        let newFees = formatter.string(from: fees)
        let newProfit = formatter.string(from: profit)
        
        grailedCommissionLabel.text = newCommission
        paypalFeesLabel.text = newFees
        profitLabel.text = newProfit
        
        return yourProfit
    }
    
}

extension String {
    var doubleValue: Double {
        return Double(self) ?? 0
    }
}
