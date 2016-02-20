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

var clickedArray =  [Int]()

class ViewController: UIViewController {
    @IBOutlet weak var circleOutlet: UIButton!

    @IBOutlet weak var crossOutlet: UIButton!
    
    @IBOutlet weak var resetOutlet: UIButton!
    var game_state=gameState.Circle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectTurn()
        
        resetOutlet.addGestureRecognizer(
            UITapGestureRecognizer(target:self,action:"resetClicked:")
        )
    }
    
    func resetClicked(gesturerecorgnizer:UITapGestureRecognizer){
        clickedArray =  [Int]()
        
        game_state = .Circle
        selectTurn()
        
        for sv in self.view.subviews{
            if sv.tag>0 {
                (sv as! UIButton).setTitle("",forState:UIControlState.Normal)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func fieldTouched(sender: UIButton) {
        
        if(!clickedArray.contains(sender.tag)){
            switch game_state{
                case .Circle:
                    sender.setTitle("O",forState:UIControlState.Normal)
                case .Cross:
                    sender.setTitle("X",forState:UIControlState.Normal)
            }
        
            game_state.next()
        
            self.selectTurn()
            
            clickedArray.append(sender.tag)
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

}

