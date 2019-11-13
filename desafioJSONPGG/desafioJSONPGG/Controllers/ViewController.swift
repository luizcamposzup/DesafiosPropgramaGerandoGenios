//
//  ViewController.swift
//  desafioJSONPGG
//
//  Created by Luizhcarminati on 28/10/19.
//  Copyright © 2019 zupper. All rights reserved.

import UIKit

class ViewController: UIViewController {

// MARK: - Variables
    var stringJson: String = ""
    var array = [Character]()
    var stack = [String]()
    let stringElementvalids = "[{}]"
    let stringCategoryColchete = "[]"
    let stringCategoryChave = "{}"
    @IBOutlet weak var jsonTextField: UITextView!
    
// MARK: - Functions
    func validateJson(stringJson: String) -> Bool{
        
        print("stringJsonOriginal: ",stringJson)
        self.stringJson = stringJson.replacingOccurrences(of: "\\", with: "").replacingOccurrences(of: " ", with: "")
        print("stringJsonSemBarrasEEspaços: ",stringJson)
        
        array = Array(stringJson)
        if (array.count > 0), (processArray(a: array) && stack.count == 0){
                return true
            }
        return false
    }

    func processArray(a: Array<Character>) -> Bool{
        for i in 0...a.count-1{
            let valueArray = String(a[i])
            if(!processValueArray(s: valueArray, a: stack)){
                return false
            }
        }
        return true
    }

    func processValueArray(s: String, a: Array<String>) -> Bool{
        if stringElementvalids.contains(s) {
            return processElementValid(s: s, a: a)
        }
        return true
    }

    func processElementValid(s:String, a: Array<String>) -> Bool{
        if verifyIsOpenElement(s: s) {
            return processElementOpen(s: s, a: a)
        }
        return processElementClose(s: s, a: a)
    }

    func processElementOpen(s: String, a: Array<String>) -> Bool{
        if(!a.isEmpty), (verifyIfElementIsSameCategoryFromTop(s: s, a: a)) { return false
        }
        stack = pushStack(s: s, a: a)
        return true
    }

    func processElementClose(s: String, a: Array<String>) -> Bool{
        if(a.isEmpty){
            print("Inválido por pilha vazia. Símbolo: ", s)
            return false
        }
        else{ return verifyElementCloseWhenStackIsNotEmpty(s: s, a: a) }
    }

    func verifyElementCloseWhenStackIsNotEmpty(s: String, a: Array<String>) -> Bool{
        if (verifyIfElementIsSameCategoryFromTop(s: s, a: a)), (verifyIfElementIsInverseFromTop(s: s, a: a)) {
                stack = popStack(a: a)
        } else{ return false }
        return true
    }

    func verifyIsOpenElement(s: String) -> Bool{
        switch s {
        case "[":
            return true
        case "{":
            return true
        default:
            return false
        }
    }

    func verifyIfElementIsSameCategoryFromTop(s: String, a: Array<String>)->Bool{
        let element = topStack(a: a)
        if (stringCategoryColchete.contains(s) && stringCategoryColchete.contains(element)) || stringCategoryChave.contains(s) && stringCategoryChave.contains(element) {
            return true
        }
        return false
    }

    func verifyIfElementIsInverseFromTop(s: String, a: Array<String>) -> Bool{
        switch s {
        case "[":
            return topStack(a: a).contains("]")
        case "]":
            return topStack(a: a).contains("[")
        case "{":
            return topStack(a: a).contains("}")
        case "}":
            return topStack(a: a).contains("{")
        default:
            return false
        }
    }

    func topStack(a: Array<String>) -> String{
        return a[a.count-1]
    }

    func pushStack(s: String, a: Array<String>) -> Array<String>{
        var stack = a
        stack.append((s))
        print("Adicionado à pilha: ", s)
        return stack
    }

    func popStack(a: Array<String>) -> Array<String>{
        var stack = a
        print("Removido da pilha: ", stack[stack.count-1])
        stack.remove(at: stack.count-1)
        return stack
    }
    
// MARK: - IBActions
    @IBAction func validate(_ sender: Any) {

        guard let textJson = jsonTextField?.text else { return }
        let message = validateJson(stringJson: textJson) == true ? "JSON VÁLIDO!" : "NÃO É UM JSON VÁLIDO!"
        let alert = UIAlertController(title: "RESPOSTA", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
        jsonTextField?.text = ""
    }
}
