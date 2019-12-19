//
//  ElementDetailVCViewController.swift
//  Elements
//
//  Created by Margiett Gil on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit
@available(iOS 13.0, *)
class ElementDetailVCViewController: UIViewController {
    
    
    //MARK: Outlets and Variables
    @IBOutlet var elementImage: UIImageView!
    @IBOutlet var symbolLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var meltingBoilingLabel: UILabel!
    @IBOutlet var discoveredByLabel: UILabel!
    @IBOutlet var favoritedByLabel: UILabel!
    
    var elementDVC: Element?
    var allElementsDVC = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadedData()
    }
    
    func loadedData() {
        
        guard let element = elementDVC else {
            showAlert(title: "Error", message: "Could not get element")
            return
        }
        
        
        
        DispatchQueue.main.async {
            self.navigationItem.title = "Elememt Name - \(element.name)"
                       }
     //MARK: Labels
        symbolLabel.text = element.symbol
        weightLabel.text = "Number: \(element.number), Atomic Mass: \(element.atomic_mass)"
        meltingBoilingLabel.text = "Melting pot: \(String(describing: element.melt?.description)), Boiling pt: \(String(describing: element.boil))"
        discoveredByLabel.text = "Discovered by - \(String(describing: element.discoveredBy))"
        
        let imageUrl = "http://images-of-elements.com/\(element.name.lowercased()).jpg"
        
        
        if allElementsDVC {
            favoritedByLabel.text = ""
        } else {
            favoritedByLabel.text = "Favorited by - \(element.favoritedBy ?? "Margiett X Gil")"
        }
        
        elementImage.getImage(with: imageUrl) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.elementImage.image = UIImage(systemName: "person.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.elementImage.image = image
                    //self?.showAlert(title: "<3", message: "successfully added to your favorites")
                }
            }
        }
        
    }
    
    @IBAction func favoriteButton(_ sender: UIBarButtonItem) {
        
       // sender.isEnabled = false
        
        guard let element = elementDVC else {
            showAlert(title: "App Error", message: "Issue uploading data")
            return
        }
        let fave = Element(name: element.name, number: element.number, symbol: element.symbol, source: element.source, atomic_mass: element.atomic_mass, melt: element.melt, boil: element.boil, discoveredBy: element.discoveredBy, id: element.id, favoritedBy: "Margiett X Gil")
        
        
        ElementAPIClient.postFave(favoriteElementPost: fave) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Failed to Post", message: "\(appError)")
                    //sender.isEnabled = true
                }
            case .success:
                DispatchQueue.main.async {
                    self?.showAlert(title: "Favorite Posted", message: "Thank You, Your element has been added to Favorites ") { alert in
                        self?.dismiss(animated: true)
                    }
                }
            }
        }
    }
    
    
}
