//
//  ConcentrationThemeChooserVC.swift
//  Concentration
//
//  Created by Sergey Sokolkin on 17.06.2021.
//  Copyright © 2021 Siarhei Sakolkin. All rights reserved.
//

import UIKit

protocol ThemeSelectionDelegate: class {
    func themeSelected(_ newTheme: String)
}

class ConcentrationThemeChooserVC: UITableViewController {
    
    weak var delegate: ThemeSelectionDelegate?
    
    let themes = [
        "Sports": "⚽️🏀🏈⚾️🥎🎾🏐🏉🥏🎱🪀🏓🏸🏒🏑",
        "Halloween": "💀👻👽🧙🧛🧟🦇🕷🕸🛸🎃🎭🗡⚰",
        "Faces": "😀😂😅😉😊😎😍😘🤔🤨🙄😣😥😮🤐😴🤓",
        "Animals": "🐵🐶🦊🐱🦁🐯🐮🐷🐭🐹🐰🐻🐨🐼🐥"
    ]
    lazy var themeNames = [String](themes.keys).sorted()
    
    let reuseIdentifier = "Cell"

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table View Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themeNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = themeNames[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = delegate as? ConcentrationVC,
           let theme = themes[themeNames[indexPath.row]] {
            detailVC.themeSelected(theme)
            splitViewController?.showDetailViewController(detailVC, sender: nil)
        }
    }

}
