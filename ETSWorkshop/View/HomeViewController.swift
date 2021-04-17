//
//  ViewController.swift
//  ETSWorkshop
//
//  Created by Kaan Ozdemir on 16.04.2021.
//

import UIKit

class HomeViewController: UIViewController {

    let viewModel = HomeViewModel()
    
    var toggleTapGesture: UITapGestureRecognizer!
    
    // MARK: IBOutlets
    @IBOutlet weak var navigationTitleLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.register(UINib(nibName: PersonTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: PersonTableViewCell.cellIdentifier)
        }
    }
    
    @IBOutlet weak var addButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.cellIdentifier, for: indexPath) as! PersonTableViewCell
        
        // Addting Tap Gesture to name label
        toggleTapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleCell))
        cell.nameLabel.addGestureRecognizer(toggleTapGesture)
        cell.nameLabel.tag = indexPath.row
        
        let person = viewModel.persons[indexPath.row]
        cell.setWith(person)
        return cell
    }
    
    
}

extension HomeViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

// MARK: IBOutlets Actions
extension HomeViewController{
    
    @IBAction func addButtonTapped(_ sender: Any) {
    }
}

extension HomeViewController{
    @objc func toggleCell(_ gesture: UITapGestureRecognizer) {
        if let nameLabel = gesture.view as? UILabel{
            
            let indexPath = IndexPath(row: nameLabel.tag, section: 0)
            viewModel.toggleCell(index: indexPath.row)
            tableView?.beginUpdates()
            tableView?.reloadRows(at: [indexPath], with: .fade)
            tableView?.endUpdates()
        }
    }
}
