//
//  drawTableView.swift
//  drawView
//
//  Created by Tony Monckton on 29/07/2019.
//  Copyright © 2019 Tony Monckton. All rights reserved.
//

import UIKit

class drawTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    private let cellId = "drawCellID"
    private var drawData = [drawModel]()
    private var drawDelegate: drawDelegate?
    
    func delegate(delegate: drawDelegate?) {
        self.drawDelegate = delegate
    }
    
    init() {
        super.init(frame: CGRect.zero, style: UITableView.Style.plain)
        
        self.delegate = self
        self.dataSource = self
        self.register(drawTableCell.self, forCellReuseIdentifier: cellId)
        
        self.bounces = false
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func add(data: drawModel) {
        drawData.append(data)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drawData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! drawTableCell
        
        cell.cellData = drawData[indexPath.row]
        cell.contentView.backgroundColor = .white

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("select row: ", indexPath.row)
        
        let index = indexPath.row
        let cellSelect:UITableViewCell = tableView.cellForRow(at: indexPath)!
        cellSelect.contentView.backgroundColor = .white
      
        drawData[index].toggleStatus()
        let drawCell = cellSelect as! drawTableCell
        drawCell.cellData = drawData[index]
        
        var dCode:drawCode = .unselected
        if ( drawData[index].status == true ) { dCode = .selected }
        
        drawDelegate?.selectedClicked(code: dCode, result: "\(index)" )
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print ("select row: ", indexPath.row)
        let cellSelect:UITableViewCell = tableView.cellForRow(at: indexPath)!
        cellSelect.contentView.backgroundColor = .white
    }
}

