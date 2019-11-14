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
         
        //Initialize the mutable string
        myMutableString = NSMutableAttributedString(
            string: myString,
            attributes: [NSAttributedString.Key.font:
                UIFont(name: "Hiragino Sans W6", size: 25.0)!])
         
        //Add more attributes here:
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor,
            value: UIColor.green,
            range: NSRange(
                location:17,
                length:11))
        myMutableString.addAttribute(NSAttributedString.Key.strokeColor,
            value: UIColor.blue,
            range:  NSRange(
                location: 0,
                length: 16))
        

        //Apply to the label
        textLabel.attributedText = myMutableString
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
}

