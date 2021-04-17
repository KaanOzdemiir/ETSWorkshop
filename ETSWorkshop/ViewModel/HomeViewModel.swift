//
//  HomeViewModel.swift
//  ETSWorkshop
//
//  Created by Kaan Ozdemir on 16.04.2021.
//

import Foundation
import RxSwift

class HomeViewModel {
    
    let disposeBag = DisposeBag()
    var persons: [PersonData] = []
    var filteredPersons: [PersonData] = []
    var isSearching: Bool = false
    
    init() {
        persons = fetchPersons()
    }
    
    func toggleCell(index: Int) {
        persons[index].isCollabsed = !persons[index].isCollabsed
    }
    
    func filterBy(_ keyword: String) {
        filteredPersons = persons.filter({
            ($0.name?.contains(keyword) ?? false) || ($0.surname?.lowercased().contains(keyword) ?? false) || ($0.email?.lowercased().contains(keyword) ?? false) || ($0.phoneNumber?.lowercased().contains(keyword) ?? false)
        })
        
    }
    
    func getPersonBy(_ indexPath: IndexPath) -> PersonData {
        return isSearching ? filteredPersons[indexPath.row] : persons[indexPath.row]
    }
    
    func getNumberOfRowInSection() -> Int {
        return isSearching ? filteredPersons.count : persons.count
    }
    
    func fetchPersons() -> [PersonData] {
        let persons = [
            PersonData(
                name: "Alper",
                surname: "Büyük",
                birthdatTimeStamp: 1506506810,
                email: "etstur@etstur.com",
                phoneNumber: "+905111111111",
                note: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
            ),
            PersonData(
                name: "Ali",
                surname: "Tunç",
                birthdatTimeStamp: 1506506810,
                email: "etstur@etstur.com",
                phoneNumber: "+905111111111",
                note: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
            ),
            PersonData(
                name: "Ayşe",
                surname: "Bolu",
                birthdatTimeStamp: 1506506810,
                email: "etstur@etstur.com",
                phoneNumber: "+905111111111",
                note: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
            )
        ]
        return persons
    }
}
