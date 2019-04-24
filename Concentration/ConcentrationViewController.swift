//
//  ViewController.swift
//  Concentration
//
//  Created by Maxwell Chukwuemeka on 12/12/2018.
//  Copyright © 2018 Maxwell. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {

    private lazy var game = Concentration(numberOfPairsOfCards : numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int{
        return(visibleCardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0{
        didSet{
//            flipCountLabel.text = "Flips: \(flipCount)"
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key : Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        
        let attributedString = NSAttributedString(
            string: traitCollection.verticalSizeClass == .compact ? "Flips:\n\(flipCount)" : "Flips:\(flipCount)",
            attributes: attributes
        )
        flipCountLabel.attributedText = attributedString
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateFlipCountLabel()
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var visibleCardButtons: [UIButton]! {
        return cardButtons?.filter { !$0.superview!.isHidden}
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViewFromModel()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        print("agh! a ghost")
        flipCount += 1
        //flipCard(withEmoji: "👻", on: sender)
        if let cardNumber = visibleCardButtons.index(of: sender){
            defer{
                updateViewFromModel()
            }
            //flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
            //print("cardNumber = \(cardNumber)")
            game.chooseCard(at: cardNumber)
        }else{
            print("The selected card is not in visibleCardButtons")
        }
        
    }
    
    private func updateViewFromModel(){
        if visibleCardButtons != nil{
            for index in visibleCardButtons.indices{
                let button = visibleCardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp{
                    button.setTitle(emoji(for: card), for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                }else{
                    button.setTitle("", for: UIControl.State.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                }
            }
        }
    
    }
    
    
    var theme: String? {
        didSet{
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    //private var emojiChoices = ["🎃","👻","🤖","😈","🍎","🥑","🍞","🍗"]
    private var emojiChoices = "🎃👻🤖😈🍎🥑🍞🍗"
    
    //Dictionary<Int,String>
    private var emoji = [Int:String]()
    
    private func emoji(for card : Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0{
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
                emoji[card.identifier] = String(emojiChoices.remove(at: randomStringIndex))
            }
        return emoji[card.identifier] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else {
            return 0
        }
    }
}

