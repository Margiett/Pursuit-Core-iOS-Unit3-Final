//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit
@available(iOS 13.0, *)

//MARK: Element View Controller
class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var elements = [Element](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadData()
        
    }
    //MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailElementCV = segue.destination as? ElementDetailVCViewController,
            let indexPath = tableView.indexPathForSelectedRow else {
                fatalError("Could not segue")
        }
        let element = elements[indexPath.row]
        detailElementCV.elementDVC = element
        detailElementCV.allElementsDVC = true
    }
    
    //MARK: LoadData
    func loadData() {
        ElementAPIClient.getElements(for: elements) { [weak self] (result) in
            switch result {
            case .failure(let appError):
              DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: "\(appError)")
                }
            case .success(let element):
                DispatchQueue.main.async {
                    self?.elements = element.sorted { $0.number < $1.number }
                }
                
            }
        }
    }

}


//MARK: Extensions
@available(iOS 13.0, *)
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as! ElementCellTableViewCell
        let cellForRowElement = elements[indexPath.row]
        cell.configureCell(for: cellForRowElement)
        return cell
    }
}
@available(iOS 13.0, *)
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

