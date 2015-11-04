//
//  Player.swift
//  ForTheWin
//
//  Created by C Sinclair on 10/30/15.
//  Copyright © 2015 femtobyte. All rights reserved.
//

import Foundation

class Player: Character{
    private var _name = "Player"
    private var _charType = "Type"
    
    var name:String{
        get{return _name}
    }
    
    var charType: String{
        get{return _charType}
    }
    
    convenience init(name: String, charType: String, hp: Int, ap: Int){
        self.init(startingHP: hp, attackPwr: ap)
        _name = name
        _charType = charType
    }
//   
//    func assignName(name: String){
//        _name = name
//    }
//    
//    func assignType(name: String){
//        _charType = charType
//    }
    
}