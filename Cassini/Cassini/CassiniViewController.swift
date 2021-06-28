//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Sergey Sokolkin on 28.06.2021.
//  Copyright © 2021 Siarhei Sakolkin. All rights reserved.
//

import UIKit

protocol ImageSelectionDelegate: AnyObject {
    func imageURLSelected(_ newImageURL: URL, title: String)
}

class CassiniViewController: UIViewController, UISplitViewControllerDelegate {
    
    weak var delegate: ImageSelectionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }

    @IBAction func pressedImageButton(_ sender: UIButton) {
        if let identifier = sender.currentTitle {
            if let url = DemoURLs.NASA[identifier],
               let detailVC = delegate as? ImageViewController {
                detailVC.imageURLSelected(url, title: identifier)
                splitViewController?.showDetailViewController(detailVC, sender: nil)
            }
        }
    }
    
    @available(iOS 14.0, *)
    func splitViewController(_ svc: UISplitViewController, topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
        return .primary
    }
    
}
