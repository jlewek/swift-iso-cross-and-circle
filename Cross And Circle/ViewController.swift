//
//  ViewController.swift
//  Cross And Circle
//
//  Created by Jakub Lewek on 20.02.2016.
//  Copyright © 2016 educativo. All rights reserved.
//

import UIKit

enum gameState{
    case Cross, Circle
    
    mutating func next(){
        switch self{
        case .Circle:
            self=Cross
        case .Cross:
            self=Circle
        }
    }
}

var clickedArray = [0,0,0,0,0,0,0,0,0]

class ViewController: UIViewController {
    @IBOutlet weak var circleOutlet: UIButton!

    @IBOutlet weak var crossOutlet: UIButton!
    
    @IBOutlet weak var resetOutlet: UIButton!
    var game_state = gameState.Circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectTurn()
        
        resetOutlet.addGestureRecognizer(
            UITapGestureRecognizer(target:self,action:"resetClicked:")
        )
    }
    
    func resetClicked(gesturerecorgnizer:UITapGestureRecognizer){
        resetGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func fieldTouched(sender: UIButton) {
        if clickedArray[sender.tag-1] == 0 {
            switch game_state{
                case .Circle:
                    sender.setTitle("O",forState:UIControlState.Normal)
                    clickedArray[sender.tag-1] = 1
                case .Cross:
                    sender.setTitle("X",forState:UIControlState.Normal)
                    clickedArray[sender.tag-1] = 2
            }
        
            if checkWin(clickedArray[sender.tag-1]) {
                
                let alert = UIAlertView()
                alert.title = "GAME OVER"
                
                if clickedArray[sender.tag-1] == 1 {
                    alert.message = "Circle is winner!"
                } else {
                    alert.message = "Cross is winner!"
                }
                
                alert.addButtonWithTitle("OK!")
                alert.show()
                
                resetGame()
                
            }
            
            game_state.next()
        
            self.selectTurn()
        }
    }
    
    func resetGame(){
        clickedArray =  [0,0,0,0,0,0,0,0,0]
        game_state = .Circle
        
        selectTurn()
        
        for sv in self.view.subviews{
            if sv.tag>0 {
                (sv as! UIButton).setTitle("",forState:UIControlState.Normal)
            }
        }
    }
    
    func selectTurn(){
        switch game_state{
        case .Circle:
            circleOutlet.selected=true
            crossOutlet.selected=false
        case .Cross:
            circleOutlet.selected=false
            crossOutlet.selected=true
        }
    }
    
    func checkWin(who: Int) -> Bool{
        let winConfigurations = [
            [1,2,3],
            [4,5,6],
            [7,8,9],
            [1,4,7],
            [2,5,8],
            [3,6,9],
            [1,5,9],
            [3,5,7]
        ]
        
        var lineCounter = 0;
        
        for configuration in winConfigurations {
            for field in configuration {
                if clickedArray[field-1] == who {
                    lineCounter++
                }
                if lineCounter == 3{
                    return true;
                }
            }
            lineCounter = 0;
        }
        return false;
    }

}

