//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Maxwell Chukwuemeka on 26/01/2019.
//  Copyright © 2019 Maxwell. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: CCLLogingViewController, UISplitViewControllerDelegate {

    override var vclLoggingName: String{
        return "ThemeChooser"
    }
    
    let themes = [
        "Sports":"🚣🏼‍♀️🏄🏻‍♀️🏈🏉🏀🥊🎱🎳⚽️🎾🥎🏅⚾️⛸",
        "Animal":"🦓🦒🦔🦕🦖🦝🦗🦙🦛🦢🦡🦜🦞🐇🐊🐖",
        "Face":"👱‍♀️🤦‍♀️🙅🏻‍♀️👷🏻‍♀️🤦🏼‍♂️👳🏼‍♂️👮🏼‍♂️🏃🏼‍♀️😍😌🤔😒😈😂🤒🤖😡🤡"
    ]
    
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController{
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName]{
                cvc.theme = theme
            }
        }else if let cvc = lastSeguedToConcentrationViewController{
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName]{
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        }else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var splitViewDetailConcentrationViewController: ConcentrationViewController?{
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }

    // MARK: - Navigation
    
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let button = sender as? UIButton{
                // if u dont want the abov e if u can put it like this (sender as? UIButton)?.currentTitle
                if let themeName = button.currentTitle, let theme = themes[themeName]{
                    if let cvc = segue.destination as? ConcentrationViewController{
                        cvc.theme = theme
                        lastSeguedToConcentrationViewController = cvc
                    }
                }
            }
        }
    }
    

}
