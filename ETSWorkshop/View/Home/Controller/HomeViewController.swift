//
//  ViewController.swift
//  ETSWorkshop
//
//  Created by Kaan Ozdemir on 16.04.2021.
//

import UIKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {

    let viewModel = HomeViewModel()
    
    var toggleTapGesture: UITapGestureRecognizer!
    
    // MARK: IBOutlets
    @IBOutlet weak var navigationTitleLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!{
        didSet{
            searchTextField.setupLeftImage(imageName: "ic_search")
        }
    }
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.register(UINib(nibName: PersonTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: PersonTableViewCell.cellIdentifier)
        }
    }
    
    @IBOutlet weak var addButton: UIButton!
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setFont()
        configureSearchProcess()
    }
    
    func setFont() {
        navigationTitleLabel.font = FontFace.mediumFont(size: 36)
        searchTextField.font = FontFace.regularFont(size: 14)
    }
}

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getNumberOfRowInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.cellIdentifier, for: indexPath) as! PersonTableViewCell
        
        // Addting Tap Gesture to name label
        toggleTapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleCell))
        cell.nameLabel.addGestureRecognizer(toggleTapGesture)
        cell.nameLabel.tag = indexPath.section
        cell.setWith(viewModel.getPersonBy(indexPath))
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.fetchIndexTitles()
    }
}

extension HomeViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        performSegue(withIdentifier: "SeguePersonDetailVC", sender: viewModel.getPersonBy(indexPath))
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
        performSegue(withIdentifier: "SeguePersonDetailVC", sender: nil)
    }
}

extension HomeViewController{
    @objc func toggleCell(_ gesture: UITapGestureRecognizer) {
        if let nameLabel = gesture.view as? UILabel{
            view.endEditing(true)
            let indexPath = IndexPath(row: 0, section: nameLabel.tag)
            viewModel.toggleCell(index: indexPath.section)
            tableView?.beginUpdates()
            tableView?.reloadRows(at: [indexPath], with: .fade)
            tableView?.endUpdates()
        }
    }
}

// MARK: Search
extension HomeViewController{
    func configureSearchProcess() {
    
        // If Non-Empty
        searchTextField
            .rx.text
            .orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance) // 0.5 second delay
            .distinctUntilChanged() // If previous text changes
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [weak self] text in
                print("Search Bar Text --> ", text)
                guard let self = self else { return }
                
                self.viewModel.isSearching = true
                self.viewModel.filterBy(text.lowercased())
                self.tableView.reloadData()
            })
            .disposed(by: viewModel.disposeBag)
        
        // If Empty
        searchTextField
            .rx.text
            .orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
            .filter { $0.isEmpty } // If the new value is really new, filter for non-empty query.
            .skip(1)
            .subscribe(onNext: { [weak self] _ in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                guard let self = self else { return }
                self.viewModel.isSearching = false
                self.tableView.reloadData()
            })
            .disposed(by: viewModel.disposeBag)
    }
}

// MARK: Segues
extension HomeViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "SeguePersonDetailVC":
            
            let person = sender as? PersonData
            let vc = segue.destination as? PersonDetailVC
            vc?.viewModel = PersonDetailViewModel(person: person, mode: person == nil ? .new : .update)
            subscribePersonDataUpdate(vc: vc)
            
        default:
            break
        }
    }
    
    func subscribePersonDataUpdate(vc: PersonDetailVC?) {
        vc?.viewModel.rxPersonUpdated.single().subscribe(onNext: { [weak self] (data) in
            guard let self = self else { return }
            switch data.mode {
            case .new:
                guard let newPerson = data.person else {
                    return
                }
                self.viewModel.persons.append(newPerson)
                self.tableView.reloadData()
            case .update:
                if let lastSelectedIndexPath = self.viewModel.lastSelectedIndexPath, let updatedPerson = data.person{
                    updatedPerson.isCollabsed = false
                    self.viewModel.update(updatedPerson, indexPath: lastSelectedIndexPath)
                    self.tableView.reloadRows(at: [lastSelectedIndexPath], with: .none)
                }
            }
            
        }).disposed(by: viewModel.disposeBag)
    }
}
