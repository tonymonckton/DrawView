//
//  ViewController.swift
//  drawView
//
//  Created by Tony Monckton on 26/07/2019.
//  Copyright © 2019 Tony Monckton. All rights reserved.
//



import UIKit

class ViewController: UIViewController, drawDelegate {

    var draw:drawView!
    var options:UIButton!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK- 3 dot menu
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        if options.tag == 0 {
            draw.show()
            options.tag = 1
        } else {
            draw.hide()
            options.tag = 0
        }
    }
    
    // delegate responce
    func selectedClicked(code: drawCode, result: String) {
        print("Viewcontroler delegate: ", code, result)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupDrawView()

        draw.snp.makeConstraints{ (make) -> Void in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        // MARK- options button
        options                 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        options.tag             = 0
        options.backgroundColor = UIColor.clear
        options.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        options.setImage(UIImage(named: "icon-dots3"), for: .normal)
//        options.layer.borderWidth = 1
//        options.layer.borderColor = UIColor.black.cgColor
        
        view.addSubview(options)
        
        options.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(20)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
    }
}

extension ViewController {
    
    func setupDrawView() {
        draw = drawView(frame: CGRect.zero)
        draw.delegate(delegate: self)
        view.addSubview(draw)
        
        draw.snp.makeConstraints{ (make) -> Void in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
