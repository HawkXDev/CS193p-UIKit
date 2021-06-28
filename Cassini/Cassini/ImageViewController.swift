//
//  ImageViewController.swift
//  Cassini
//
//  Created by Sergey Sokolkin on 25.06.2021.
//  Copyright © 2021 Siarhei Sakolkin. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    var imageURL: URL? {
        didSet {
            image = nil

            if view.window != nil { // check am I on-screen
                fetchImage()
            }
        }
    }
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            
            imageView.sizeToFit()
            scrollView.contentSize = imageView.frame.size
        }
    }
    
    var imageView = UIImageView()

    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 1.0
            
            scrollView.delegate = self
            
            scrollView.addSubview(imageView)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageURL == nil {
            imageURL = DemoURLs.stanford
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
    
    private func fetchImage() {
        if let url = imageURL {
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents {
                image = UIImage(data: imageData)
            }
        }
    }
    
}

// MARK: - ImageSelectionDelegate

extension ImageViewController: ImageSelectionDelegate {
    func imageSelected(_ newImageURL: URL) {
        
    }
}
