//
//  ElementCellTableViewCell.swift
//  Elements
//
//  Created by Margiett Gil on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
@available(iOS 13.0, *)
class ElementCellTableViewCell: UITableViewCell {
    
    //MARK: Outlets and variables
    
    var cellElement = ""
    
    @IBOutlet weak var elementImageView: UIImageView!
    @IBOutlet weak var elementLabel: UILabel!
    @IBOutlet weak var elementLbale2:UILabel!
    
    //MARK: Congirguring Cell 
    func configureCell(for element: Element) {
        elementLabel.text = element.number.description
        elementLbale2.text = "\(element.symbol) (\(element.number)) \(element.atomic_mass)"
         
         
         if element.number < 10 {
             cellElement = "00\(element.number)"
         } else if element.number < 100 && element.number >= 10{
             cellElement = "0\(element.number)"
         } else {
             cellElement = element.number.description
         }
      
         
         let imageURL = "http://www.theodoregray.com/periodictable/Tiles/\(cellElement)/s7.JPG"
         
        
            
            elementImageView.getImage(with: imageURL) { [weak self] (result) in
                switch result {
                case .failure:
                    DispatchQueue.main.sync {
            self?.elementImageView.image = UIImage(systemName: "person.fill")
                        }
                case .success(let image):
                    DispatchQueue.main.sync {
                        self?.elementImageView.image = image
                    }
                }
            }
      
        }
 }
