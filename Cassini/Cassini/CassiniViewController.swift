//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Sergey Sokolkin on 28.06.2021.
//  Copyright © 2021 Siarhei Sakolkin. All rights reserved.
//

import UIKit

protocol ImageSelectionDelegate: AnyObject {
    func imageSelected(_ newImageURL: URL)
}

class CassiniViewController: UIViewController {
    
    weak var delegate: ImageSelectionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
