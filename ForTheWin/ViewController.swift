//
//  ViewController.swift
//  ForTheWin
//
//  Created by C Sinclair on 10/30/15.
//  Copyright © 2015 femtobyte. All rights reserved.
//

//  Feature ideas and bugs:
//  bug: restart button doesn't work
//  A New Game button could be added where you would choose new chars again. Will keep restart as just replaying new game with same chars.
//  changing orientation of images so they always face each other would be nice

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var player1Btn: UIButton!
    @IBOutlet weak var player2Btn: UIButton!
    @IBOutlet weak var attack1Lbl: UILabel!
    @IBOutlet weak var attack2Lbl: UILabel!
    @IBOutlet weak var readOutBackdrop: UIImageView!
    
    @IBOutlet weak var playerStack: UIStackView!
    @IBOutlet weak var attackStack: UIStackView!
    @IBOutlet weak var ReadOutLbl: UILabel!
    @IBOutlet weak var player1HPLbl: UILabel!
    @IBOutlet weak var player2HPLbl: UILabel!
    @IBOutlet weak var playerTwoImg: UIImageView!
    @IBOutlet weak var playerOneImg: UIImageView!
    
    @IBOutlet weak var restartBtn: UIButton!
    @IBOutlet weak var restartLbl: UILabel!
    @IBOutlet weak var playerNameEntry: UITextField!
    @IBOutlet weak var newGameInstructLbl: UILabel!
    
    @IBOutlet weak var groundImg: UIImageView!
    @IBOutlet weak var enemyBtn: UIButton!
    @IBOutlet weak var playerBtn: UIButton!
    var playerOne: Player!
    var playerTwo: Player!
    var playerNames = [String]()
    var playerTypes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // handles dismissing keyboard if you touch outside the keyboard
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func initializePlayers(){
        if playerNameEntry.text != nil && playerNameEntry.text != ""{
            if let name = playerNameEntry.text{
                playerNames.append(name)
                playerNameEntry.text = ""
            }
        }
        if playerNames.count == 1{
            newGameInstructLbl.text = "Welcome \(playerNames[0])!  Player Two: Enter your name and choose your character "
        }

        if playerNames.count == 2 && playerTypes.count == 2{
            playerOne = Player(name: "\(playerNames[0])", charType: "\(playerTypes[0])", hp: 100, ap: 20)
            playerTwo = Player(name: "\(playerNames[1])", charType: "\(playerTypes[1])", hp: 100, ap: 20)
            setScene()
        }
    }
    
    func setScene(){
        playerNameEntry.hidden = true
        newGameInstructLbl.hidden = true
        enemyBtn.hidden = true
        playerBtn.hidden = true
        
        groundImg.hidden = false
        attackStack.hidden = false
        playerStack.hidden = false
        attack1Lbl.hidden = false
        attack2Lbl.hidden = false
        ReadOutLbl.hidden = false
        player1HPLbl.hidden = false
        player2HPLbl.hidden = false
        if(playerOne.charType == "player"){
            playerOneImg.transform = CGAffineTransformMakeScale(-1, 1)}
        if(playerTwo.charType == "enemy"){
            playerTwoImg.transform = CGAffineTransformMakeScale(-1, 1)}
        playerOneImg.image = UIImage(named:"\(playerOne.charType)")
        playerTwoImg.image = UIImage(named:"\(playerTwo.charType)")
        player1HPLbl.text = "\(playerOne.hp) HP"
        player2HPLbl.text = "\(playerTwo.hp) HP"

    }
    
    func flipImage(player: Player){
        
    }
    
    func disableAttackBtns(){
        player1Btn.enabled = false
        player2Btn.enabled = false

    }
    
    func enableAttackBtns(){
        if(playerOne.isAlive && playerTwo.isAlive){
            player1Btn.enabled = true
            player2Btn.enabled = true
        }
    }
    
    func restartChoice(){
        ReadOutLbl.text = "Would you like to play again?"
        restartBtn.hidden = false
        restartLbl.hidden = false
    }
    
    func timer(myFunction: String){
        NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: Selector(myFunction), userInfo: nil, repeats: false)
    }

    func endGame(player: Player){
        ReadOutLbl.text = "\(player.name) wins"
        timer("restartChoice")
        disableAttackBtns()
    }
    
    
    
    @IBAction func onPlayer1BtnPressed(sender: AnyObject) {
        if playerTwo.onAttack(playerOne.ap){
            player2HPLbl.text = "\(playerTwo.hp) HP"
            ReadOutLbl.text = "\(playerOne.name) hit \(playerTwo.name) for \(playerOne.ap)"
        }
        self.player2Btn.enabled = false
        timer("enableAttackBtns")
        if !playerTwo.isAlive{
            player2HPLbl.text = "0"
            endGame(playerOne)
        }
    }
    
    @IBAction func onPlayer2BtnPressed(sender: AnyObject) {
        if playerOne.onAttack(playerTwo.ap){
            player1HPLbl.text = "\(playerOne.hp) HP"
            ReadOutLbl.text = "\(playerTwo.name) hit \(playerOne.name) for \(playerTwo.ap)"
        }
        self.player1Btn.enabled = false
        timer("enableAttackBtns")
        if !playerOne.isAlive{
            player1HPLbl.text = "0 HP"
            endGame(playerTwo)
        }
    }
    
    @IBAction func onRestartBtnPressed(sender: AnyObject) {
        ReadOutLbl.text = "Press Attack to Attack"
        playerOne.resetHP()
        playerTwo.resetHP()
        player1HPLbl.text = "\(playerOne.hp) HP"
        player2HPLbl.text = "\(playerTwo.hp) HP"
        enableAttackBtns()
        restartBtn.hidden = true
        restartLbl.hidden = true
    }
    
    @IBAction func onEnemyPressed(sender: AnyObject) {
        playerTypes.append("enemy")
        initializePlayers()
    }
    
    @IBAction func onPlayerPressed(sender: AnyObject) {
        playerTypes.append("player")
        initializePlayers()
    }
}

