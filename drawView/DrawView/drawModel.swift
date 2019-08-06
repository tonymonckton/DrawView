//
//  drawModel.swift
//  drawView
//
//  Created by Tony Monckton on 29/07/2019.
//  Copyright © 2019 Tony Monckton. All rights reserved.
//

import Foundation

struct drawModel {
    var status: Bool
    var imageNameOn: String
    var imageNameOff: String
    var mainText: String
    var data: String
    
    mutating func toggleStatus() {
        if ( status == true )   {  status = false }
        else                    { status = true }
    }
}
