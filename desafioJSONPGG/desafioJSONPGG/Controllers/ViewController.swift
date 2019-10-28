//
//  ViewController.swift
//  desafioJSONPGG
//
//  Created by zupper on 28/10/19.
//  Copyright © 2019 zupper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var jsonTextField: UITextField?
    

    @IBAction func validate(_ sender: Any) {

        guard let textJson = jsonTextField?.text else {
            return
        }
        
        if validateJson(s: textJson) == true {
                let alert = UIAlertController(title: "Resposta", message: "JSON válido!", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
        } else {
            let alert = UIAlertController(title: "Resposta", message: "NÃO é um JSON válido!", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
        }
        
        
    }
    
    var stringJson: String = ""
    var array = [Character]()
    var stack = [String]()
    let stringElementvalids = "[{}]"
    let stringCategoryColchete = "[]"
    let stringCategoryChave = "{}"

    func validateJson(s: String) -> Bool{
        
        print("stringJsonOriginal: ",stringJson)
        
        stringJson = replaceCharacter(stringJson, "\\", "")
        stringJson = replaceCharacter(stringJson, " ", "")
        print("stringJsonSemBarrasEEspaços: ",stringJson)
        
        array = convertStringToArray(s: stringJson)
        
        if(processArray(a: array) && stack.count == 0){
            return true
        }
        else{
            return false
        }
    
    }

    func convertStringToArray(s: String) -> Array<Character>{
        return Array(s)
    }

    func processArray(a: Array<Character>) -> Bool{
        var result = true
        for i in 0...a.count-1{
            let valueArray = String(a[i])
            if(!processValueArray(s: valueArray, a: stack)){
                result = false
                break
            }
        }
        
        return result
    }

    func processValueArray(s: String, a: Array<String>) -> Bool{
        
        var result = true
        
        if(verifyIfIsValidElement(s: s)){
            result = processElementValid(s: s, a: a)
        }
        
        return result
    }

    func verifyIfIsValidElement(s: String) -> Bool{
        return stringElementvalids.contains(s)
    }

    func processElementValid(s:String, a: Array<String>) -> Bool{
        var result = true
        
        if(verifyIsOpenElement(s: s)){
            result = processElementOpen(s: s, a: a)
        }
        else {
            result = processElementClose(s: s, a: a)
        }
        
        return result
    }

    func processElementOpen(s: String, a: Array<String>) -> Bool{
        var result = true
        
        if(!verifyIfStackIsEmpty(a: a)){
            if(verifyIfElementIsSameCategoryFromTop(s: s, a: a)){result = false}
            else{stack = pushStack(s: s, a: a)}
        }
        else{stack = pushStack(s: s, a: a)}
        
        return result
    }

    func processElementClose(s: String, a: Array<String>) -> Bool{
        var result = true
        
        if(verifyIfStackIsEmpty(a: a)){
            result = false
            print("Inválido por pilha vazia. Símbolo: ", s)
        }
        else{
            result = verifyElementCloseWhenStackIsNotEmpty(s: s, a: a)
            
        }
        
        return result
    }

    func verifyElementCloseWhenStackIsNotEmpty(s: String, a: Array<String>) -> Bool{
        var result = true
        
        if (verifyIfElementIsSameCategoryFromTop(s: s, a: a)){
            if(verifyIfElementIsInverseFromTop(s: s, a: a)){
                stack = popStack(a: a)
            }
            else{
                result = false
                print("Inválido por símbolo não inverso no topo. Símbolo: ", s)
            }
        }
        else{
            result = false
        }
        
        return result

    }

    func verifyIsOpenElement(s: String) -> Bool{
        
        var result = false
        
        switch s {
        case "[":
            result = true
        case "{":
            result = true
            
        default:
            result = false
        }
        return result
    }

    func verifyIfStackIsEmpty(a: Array<String>) -> Bool{
        return a.isEmpty
    }

    func verifyIfElementIsSameCategoryFromTop(s: String, a: Array<String>)->Bool{
        var result = false
        
        let element = topStack(a: a)

        if(elementIsCategoryColchete(s: s) &&
            elementIsCategoryColchete(s: element)){
            result = true
        }
        else if (elementIsCategoryChave(s: s) &&
            elementIsCategoryChave(s: element)){
            result = true
        }
        
        return result
    }

    func elementIsCategoryColchete(s: String)-> Bool{
        return stringCategoryColchete.contains(s)
    }

    func elementIsCategoryChave(s: String)-> Bool{
        return stringCategoryChave.contains(s)
    }

    func verifyIfElementIsInverseFromTop(s: String, a: Array<String>) -> Bool{
        var result = false
        
        switch s {
        case "[":
            result = topStack(a: a).contains("]")
        case "]":
            result = topStack(a: a).contains("[")
        case "{":
            result = topStack(a: a).contains("}")
        case "}":
            result = topStack(a: a).contains("{")
        default:
            result = false
        }
        return result
    }

    func replaceCharacter(_ stringOriginal: String, _ of: String, _ with: String ) -> String{
        
        return stringOriginal.replacingOccurrences(of: of, with: "", options: NSString.CompareOptions.literal, range: nil)
    }

    //TOP STACK
    func topStack(a: Array<String>) -> String{
        return a[a.count-1]
    }

    //PUSH STACK
    func pushStack(s: String, a: Array<String>) -> Array<String>{
        var stack = a
        stack.append((s))
        print("Adicionado à pilha: ", s)
        return stack
    }

    //POP STACK
    func popStack(a: Array<String>) -> Array<String>{
        var stack = a
        print("Removido da pilha: ", stack[stack.count-1])
        stack.remove(at: stack.count-1)
        return stack
    }

}

