//
//  tableCellData.swift
//  drawView
//
//  Created by Tony Monckton on 29/07/2019.
//  Copyright © 2019 Tony Monckton. All rights reserved.
//

import UIKit

class drawTableCell: UITableViewCell {
    
    var cellSelected:Bool = false
    
    private let title : UILabel = {
        let lbl             = UILabel()
        lbl.textColor       = .black
        lbl.font            = UIFont(name: drawUITheme.fontNameLight(), size: 16.0)
        lbl.textAlignment   = .left
        return lbl
    }()
    
    let icon : UIImageView = {
        let imgView             = UIImageView()
        imgView.contentMode     = .scaleAspectFit
        imgView.clipsToBounds   = true
        return imgView
    }()
    
    var cellData : drawModel? {
        didSet {
            var imgName = cellData?.imageNameOn
            if ( cellData?.status == false ) {  imgName = cellData?.imageNameOff    }
            icon.image  = UIImage(named: imgName!)
            title.text  = cellData?.mainText
        }
    }
    
    func status() {
        //print( "status: ", icon.image?.accessibilityIdentifier!)
    }
    
    func update() {
        var imgName = cellData?.imageNameOn
        if ( cellData?.status == false ) {  imgName = cellData?.imageNameOff    }
        icon.image  = UIImage(named: imgName!)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white

        addSubview(icon)
        icon.snp.makeConstraints{ (make) -> Void in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(35)
            make.height.equalTo(35)
        }

        addSubview(title)
        title.snp.makeConstraints{ (make) -> Void in
            make.left.equalToSuperview().offset(75)
            make.centerY.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
