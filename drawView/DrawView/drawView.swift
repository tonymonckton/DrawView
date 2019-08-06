//
//  drawView.swift
//  drawView
//
//  Created by Tony Monckton on 26/07/2019.
//  Copyright © 2019 Tony Monckton. All rights reserved.
//
// http://www.swiftkickmobile.com/building-better-app-animations-swift-uiviewpropertyanimator/

import UIKit
import SnapKit

enum drawCode {
    case error
    case success
    case subscribe
    case unsubscribe
    case selected
    case unselected
    case share
}

private enum drawState {
    case closed
    case open
}

protocol drawDelegate {
    func selectedClicked(code: drawCode, result: String)
}

class drawView: UIView {

    private var state: drawState = .closed
    public var delegate: drawDelegate?
    
    private lazy var contentView: UIView = {
        let cView = UIView()
        cView.backgroundColor     = .white
        cView.layer.cornerRadius  = 10
        cView.layer.borderWidth   = 1
        cView.layer.borderColor   = UIColor.lightGray.cgColor
        return cView
    }()
    
    private lazy var headerImage: UIImageView = {
        let headerImage = UIImageView()
        headerImage.image = UIImage(named: "icon-handle")
        
        return headerImage
    }()
    
    private var contentTableView: drawTableView!
    
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight = UIScreen.main.bounds.size.height

    private var contentHeight:CGFloat = 0.0
    private var headerHeight:CGFloat = 20
    private var contentPercentSize: CGFloat = 40.0

    private var topFromPosition:Int = 0
    private var toptoPosition:Int   = 0
    private var hideHeader:Bool     = false
    
    
    // MARK: init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    public convenience init() {
        self.init(frame: .zero)
    }
    
    func delegate(delegate: drawDelegate?) {
        self.delegate = delegate
        contentTableView.delegate(delegate: delegate)
    }
    
    // MARK: methods
    func addToTable( imgNameOn: String, imgNameOff: String, titleText: String, data: String, status: Bool ) {
        contentTableView.add(data: drawModel(status: status, imageNameOn: imgNameOn, imageNameOff: imgNameOff, mainText: titleText, data: data))
    }

    public func adddata() {
        addToTable(imgNameOn: "icon-send1", imgNameOff: "icon-send0",  titleText: "Send link", data: "", status: false)
        addToTable(imgNameOn: "icon-like1", imgNameOff: "icon-like0",  titleText: "Like", data: "", status: false)
        addToTable(imgNameOn: "icon-add",   imgNameOff: "icon-add", titleText: "Add to favourite", data: "", status: false)
        addToTable(imgNameOn: "icon-tag1",  imgNameOff: "icon-tag0", titleText: "Tag", data: "", status: false)
    }

    func show() {
        print("show")
        let animatorShow = UIViewPropertyAnimator(duration:0.5, dampingRatio: 1) {
            self.contentView.frame.origin.y = CGFloat(self.toptoPosition)
        }
        animatorShow.startAnimation()
        state = .open
    }
    
    func hide() {
        print("hide")

        let animatorShow = UIViewPropertyAnimator(duration: 0.4, dampingRatio: 1) {
            self.contentView.frame.origin.y = CGFloat(self.topFromPosition)
        }
        animatorShow.startAnimation()
    }
    
    @objc func draggedView(_ sender: UITapGestureRecognizer) {
        print("Hello World")
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if hideHeader == true {
            headerHeight = 0
        }
        contentHeight = (UIScreen.main.bounds.size.height * contentPercentSize ) / 100.0
        
        topFromPosition = Int(screenHeight - headerHeight)
        toptoPosition   = Int(screenHeight - contentHeight) + 10

        // MARK: contentView
        self.addSubview(contentView)
        contentView.addSubview(headerImage)

        // MARK: tableview - custom tableView: drawTableView
        contentTableView = drawTableView()
        contentView.addSubview(contentTableView)

        setupLayout()

        print ("contentView.frame.origin: ",contentView.frame.origin)
        contentView.frame.origin.y = 300
        
        adddata()
    }
    
    private func setupLayout() {
        contentView.snp.makeConstraints{ (make) -> Void in
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.top.equalTo(topFromPosition)
            make.height.equalTo(contentHeight)
        }
        
        headerImage.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(contentView)
            make.height.equalTo(16)
            make.width.equalTo(50)
            make.top.equalTo(contentView).offset(4)
        }
        
        contentTableView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(contentView).offset(32)
            make.left.equalTo(contentView).offset(8)
            make.right.equalTo(contentView).offset(-8)
            make.bottom.equalTo(contentView).offset(8)
        }
    }
    
}
