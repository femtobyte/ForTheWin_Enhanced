//
//  Character.swift
//  ForTheWin
//
//  Created by C Sinclair on 10/30/15.
//  Copyright © 2015 femtobyte. All rights reserved.
//

import Foundation

class Character{
    private var _hp = 100
    private var _ap = 20
    private var _startinghp = 100   //this holds original value for restarting game
    

    var hp:Int {
        get{return _hp}
    }
    var ap:Int {
        get{return _ap}
    }
    var isAlive:Bool{
        get{
            if hp <= 0{
                return false
            }else{
                return true
            }
        }
    }

    init(startingHP: Int, attackPwr: Int){
        self._hp = startingHP
        self._ap = attackPwr
    }

    func onAttack(attackPwr:Int)->Bool{
        self._hp -= attackPwr
        
        return true
    }
    
    func resetHP(){
        self._hp = _startinghp
    }
}