//
//  buttonClass.swift
//  DesafioFibonacciFatorialPGG
//
//  Created by zupper on 13/11/19.
//  Copyright © 2019 Luizhcarminati. All rights reserved.
//

import UIKit

class ButtonClass: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        backgroundColor = #colorLiteral(red: 0.6499858499, green: 0.7582921386, blue: 0.222558856, alpha: 1)
        setTitleColor(#colorLiteral(red: 0, green: 0.2174181938, blue: 0.322963506, alpha: 1), for: .normal)
        layer.cornerRadius = frame.size.height/5
    }
}
