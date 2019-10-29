//
//  ViewController.swift
//  DesafioFibonacciFatorialPGG
//
//  Created by zupper on 29/10/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var numberTextField: UITextField?
    

    @IBAction func calculateBtn(_ sender: Any) {
        if let num = numberTextField?.text {
            if let n = Int(num) {
                let alert = UIAlertController(title: "Resposta", message: "Fibonacci de \(n) é \(fibonacci(n: n)) e fatorial de \(n)! é \(factorial(n: n))", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "erro", message: "Errou ao calcular", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                    }
        }
        numberTextField?.text = ""
    }

    func fibonacci (n: Int) -> Int {
        
        if (n <= 2) {
            return 1
        } else {
            return fibonacci(n: n-1) + fibonacci(n: n-2)
        }
    }

    func factorial (n: Int) -> Int {
        if n <= 1 {
            return 1
        } else {
            return n * factorial(n: n-1)
        }
    }


//    func factorial(n: num)
//    func fibonacci(n: num)
    
}

