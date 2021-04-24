//
//  ViewController.swift
//  PageScrollView
//
//  Created by zhaojw on 2017/11/11.
//  Copyright © 2017年 zhaojw. All rights reserved.
//

import Cocoa

let kImageWidth:  CGFloat = 40
let kImageHeight: CGFloat = 40
let kImagePaddding: CGFloat = 10

class ViewController: NSViewController {
    lazy var scrollView: PageScrollView = {
        let aScrollView = PageScrollView()
        aScrollView.focusRingType         = .none
        aScrollView.autohidesScrollers    = true
        aScrollView.hasHorizontalScroller = true
        aScrollView.borderType            = .noBorder
        aScrollView.translatesAutoresizingMaskIntoConstraints = false
        aScrollView.documentView = pageContainer
        aScrollView.delegate = self
        return aScrollView
    }()
    
    lazy var pageContainer: PageContainer = {
        let pageContainer = PageContainer()
        pageContainer.translatesAutoresizingMaskIntoConstraints = false
        return pageContainer
    }()
    
    lazy var pageIndicator: PageIndicator = {
        let pageIndicator = PageIndicator()
        pageIndicator.delegate = self
        pageIndicator.selectedColor = NSColor.red
        pageIndicator.translatesAutoresizingMaskIntoConstraints = false
        return pageIndicator
    }()
    
    func newImageView()-> NSImageView {
        let imageView = NSImageView()
        imageView.imageScaling = .scaleProportionallyUpOrDown
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    lazy var images: [NSImage] = {
        var items = [NSImage]()
        for i in 0...12 {
            if let image = NSImage(named: NSImage.Name("icon\(i+1).png")) {
                items.append(image)
            }
        }
        return items
    }()
    
    func addSubviews() {
        view.addSubview(self.scrollView)
        for image in images {
            let imageView = newImageView()
            imageView.image = image
            pageContainer.addSubview(imageView)
        }
        view.addSubview(pageIndicator)
    }
    
    var numberOfItemsInPage: Int = 6 
    
    var scrollViewWidth: CGFloat {
        return CGFloat(numberOfItemsInPage) * kImageWidth +  CGFloat(numberOfItemsInPage + 1) * kImagePaddding
    }
    
    var numberOfPages: Int {
        return Int(ceil( CGFloat(images.count) / CGFloat(numberOfItemsInPage)))
    }
    
    func setupAutoLayout() {
        
        self.scrollView.left   = 10
        self.scrollView.top    = 10
        self.scrollView.width  = scrollViewWidth
        self.scrollView.height = 60
        
        var lastView: NSView?
        for imageView in pageContainer.subviews {
            imageView.centerY   = pageContainer.centerY
            if let lastView = lastView {
                imageView.left = lastView.right + kImagePaddding
            }
            else {
                imageView.left = kImagePaddding
            }
            imageView.width   = kImageWidth
            imageView.height  = kImageHeight
            lastView = imageView
        }
        
        pageContainer.left     = self.scrollView.left
        pageContainer.bottom   = self.scrollView.bottom
        pageContainer.top      = self.scrollView.top
        
        let pageContainerWidth: CGFloat = scrollViewWidth * CGFloat(scrollView.numberOfPages)
        
        var frame = pageContainer.frame
        frame.size = NSSize(width: pageContainerWidth, height: NSView.noIntrinsicMetric)
        pageContainer.viewSize = frame.size
        pageContainer.invalidateIntrinsicContentSize()
        
        pageIndicator.left    = scrollView.left
        pageIndicator.right   = scrollView.right
        pageIndicator.top     = scrollView.bottom + 2
        pageIndicator.height  = 24
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupAutoLayout()
        pageIndicator.numberOfPages = scrollView.numberOfPages
    }
}

extension ViewController : PageScrollViewDelegate {
    func scroll(to currentPage: Int , pageScrollView: PageScrollView) {
        pageIndicator.currentPage = currentPage
    }
    func numberOfPages(in pageScrollView: PageScrollView) -> Int {
        return numberOfPages
    }
    func itemPadding(in pageScrollView: PageScrollView) -> CGFloat {
        return kImagePaddding
    }
}

extension ViewController : PageIndicatorDelegate {
    func pageIndicator(pageIndicator: PageIndicator , didSelectPageAtIndex index: Int) {
        scrollView.scroll(to: index)
    }
}


