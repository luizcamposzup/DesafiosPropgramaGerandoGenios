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
    
// MARK: - Functions
    func validateJson(stringJson: String) -> Bool{
        
        print("stringJsonOriginal: ",stringJson)
        self.stringJson = replaceCharacter(stringJson, "\\", "")
        self.stringJson = replaceCharacter(stringJson, " ", "")
        print("stringJsonSemBarrasEEspaços: ",stringJson)
        
        array = convertStringToArray(s: stringJson)
        if (array.count > 0) {
            if(processArray(a: array) && stack.count == 0){
                return true
            }
            else{ return false }
        } else { return false }
    }

    func convertStringToArray(s: String) -> Array<Character>{
        return Array(s)
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
        if(verifyIfIsValidElement(s: s)){
            return processElementValid(s: s, a: a)
        }
        return true
    }

    func verifyIfIsValidElement(s: String) -> Bool{
        return stringElementvalids.contains(s)
    }

    func processElementValid(s:String, a: Array<String>) -> Bool{
        if(verifyIsOpenElement(s: s)){
            return processElementOpen(s: s, a: a)
        }
        else { return processElementClose(s: s, a: a) }
    }

    func processElementOpen(s: String, a: Array<String>) -> Bool{
        if(!verifyIfStackIsEmpty(a: a)){
            if(verifyIfElementIsSameCategoryFromTop(s: s, a: a)){ return false }
            else {stack = pushStack(s: s, a: a)}
        }
        else {stack = pushStack(s: s, a: a)}
        return true
    }

    func processElementClose(s: String, a: Array<String>) -> Bool{
        if(verifyIfStackIsEmpty(a: a)){
            print("Inválido por pilha vazia. Símbolo: ", s)
            return false
                    }
        else{ return verifyElementCloseWhenStackIsNotEmpty(s: s, a: a) }
    }

    func verifyElementCloseWhenStackIsNotEmpty(s: String, a: Array<String>) -> Bool{
        if (verifyIfElementIsSameCategoryFromTop(s: s, a: a)){
            if(verifyIfElementIsInverseFromTop(s: s, a: a)){
                stack = popStack(a: a)
            }
            else{
                print("Inválido por símbolo não inverso no topo. Símbolo: ", s)
                return false
            }
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

    func verifyIfStackIsEmpty(a: Array<String>) -> Bool{ return a.isEmpty }

    func verifyIfElementIsSameCategoryFromTop(s: String, a: Array<String>)->Bool{
        let element = topStack(a: a)
        if(elementIsCategoryColchete(s: s) &&
            elementIsCategoryColchete(s: element)){
            return true
        }
        else if (elementIsCategoryChave(s: s) &&
            elementIsCategoryChave(s: element)){
            return true
        }
        return false
    }

    func elementIsCategoryColchete(s: String)-> Bool{
        return stringCategoryColchete.contains(s)
    }

    func elementIsCategoryChave(s: String)-> Bool{
        return stringCategoryChave.contains(s)
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

    func replaceCharacter(_ stringOriginal: String, _ of: String, _ with: String ) -> String{
        return stringOriginal.replacingOccurrences(of: of, with: "", options: NSString.CompareOptions.literal, range: nil)
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

// MARK: - IBOutlets
    @IBOutlet weak var jsonTextField: UITextField?
    
// MARK: - IBActions
    @IBAction func validate(_ sender: Any) {

        guard let textJson = jsonTextField?.text else { return }
        let alert = UIAlertController(title: "Resposta", message: "JSON válido!", preferredStyle: .alert)
            if (validateJson(stringJson: textJson)) {
                let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(ok)
            } else {
                let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(ok)
            }
        self.present(alert, animated: true, completion: nil)
        jsonTextField?.text = ""
    }
}
