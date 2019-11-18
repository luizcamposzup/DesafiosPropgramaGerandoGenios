//
//  ViewController.swift
//  DesafioFibonacciFatorialPGG
//
//  Created by zupper on 29/10/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var myString = "Calcule Fibonacci e Fatorial"
    var myMutableString = NSMutableAttributedString()
    
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        chanceTextColor()
    }

    @IBOutlet weak var numberTextField: UITextField?
    
    @IBAction func calculateFibonacci(_ sender: Any) {
        
        guard let num = numberTextField?.text, let
            n = Int(num) else { return }
        
        let alert = UIAlertController(title: "Resposta", message: "Fibonacci de \(n) é \(fibonacci(n))", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
            
        numberTextField?.text = ""
    }
    
    @IBAction func calculateFactorial(_ sender: Any) {
       guard let num = numberTextField?.text, let
            n = Int(num) else { return }
        
        let alert = UIAlertController(title: "Resposta", message: "Fatorial de \(n) é \(factorial(n))", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
            
        numberTextField?.text = ""
    }

    func fibonacci (_ n: Int) -> Int {
        if (n <= 2) {
            return 1
        } else { return fibonacci(n-1) + fibonacci(n-2) }
    }

    func factorial (_ n: Int) -> Int {
        if n <= 1 {
            return 1
        } else { return n * factorial(n-1) }
    }
        
    func chanceTextColor (){
            
        let firstAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named:"azulZup"), NSAttributedString.Key.font: UIFont(name: "Hiragino Sans W6", size: 20)]
        let secondAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named:"verdeZup"), NSAttributedString.Key.font: UIFont(name: "Hiragino Sans W6", size: 20)]
        let thirdAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange, NSAttributedString.Key.font: UIFont(name: "Hiragino Sans W6", size: 40)]

        let firstString = NSMutableAttributedString(string: "{ ", attributes: thirdAttributes as [NSAttributedString.Key : Any])
        let secondString = NSAttributedString(string: "Calculo Fibonacci ", attributes: secondAttributes as [NSAttributedString.Key : Any])
        let thirdString = NSMutableAttributedString(string: "e Fatorial ", attributes: firstAttributes as [NSAttributedString.Key : Any])
        let fourthString = NSAttributedString(string: "}", attributes: thirdAttributes as [NSAttributedString.Key : Any])

        firstString.append(secondString)
        firstString.append(thirdString)
        firstString.append(fourthString)
        
        textLabel.attributedText = firstString
        }
}

