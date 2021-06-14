//
//  ConcentrationThemeChooserVC.swift
//  Concentration
//
//  Created by Sergey Sokolkin on 14.06.21.
//  Copyright © 2021 Siarhei Sakolkin. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserVC: UIViewController {
    
    let themes = [
        "Sports": "⚽️🏀🏈⚾️🥎🎾🏐🏉🥏🎱🪀🏓🏸🏒🏑",
        "Halloween": "💀👻👽🧙🧛🧟🦇🕷🕸🛸🎃🎭🗡⚰",
        "Faces": "😀😂😅😉😊😎😍😘🤔🤨🙄😣😥😮🤐😴🤓",
        "Animals": "🐵🐶🦊🐱🦁🐯🐮🐷🐭🐹🐰🐻🐨🐼🐥"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Navigation
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChooseTheme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationVC {
                    cvc.theme = theme
                }
            }
        }
    }
    
}
