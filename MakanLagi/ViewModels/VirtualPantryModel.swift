//
//  AppViewModel.swift
//  MakanLagi
//
//  Created by Hilary Young on 16/04/2023.
//

import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


class VirtualPantryModel: ObservableObject {
    
    let auth = Auth.auth()
    let db = Firestore.firestore()
    
    @Published var signedIn = false
    @Published var userName = ""
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    // Function 4: Fetch User Name
    func fetchUserName() {
        if let currentUser = auth.currentUser {
            let userDocRef = db.collection("Users").document(currentUser.uid)
            userDocRef.getDocument { document, error in
                if let document = document, document.exists {
                    if let data = document.data(), let firstName = data["firstName"] as? String{
                        DispatchQueue.main.async {
                            //self.userName = "\(firstName) \(lastName)"
                            self.userName = "\(firstName)"
                        }
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    
    
    // Function 5: Add Leftover to User's Database (Firestore)
    var uuid: String? {
        auth.currentUser?.uid // asking for user ID
    }
    
    func addItem(newItemName: String, newExpDate: Date){
        let db = Firestore.firestore()
        let ref = db.collection("userCollection").document(self.uuid!).collection("virtualPantry").document(newItemName) // name of the doccument
        // what is inside the doccument
        ref.setData(["itemName": newItemName, "expDate": newExpDate]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    
    // Function 6: Fetching User's Virtual Pantry Data (Firestore)
    @Published var items: [UserVirtualPantry] = []

    func fetchItems() {
        items.removeAll()
        let db = Firestore.firestore()
        if let uuid = self.uuid {
            let ref = db.collection("userCollection").document(uuid).collection("virtualPantry")
            ref.getDocuments { snapshot, error in
                guard error == nil else{
                    print(error!.localizedDescription)
                    return
                }

                if let snapshot = snapshot {
                    for document in snapshot.documents{
                        let data = document.data()

                        let id = UUID().uuidString
                        let itemName = data["itemName"] as? String ?? ""
                        let expDate = (data["expDate"] as? Timestamp)?.dateValue() ?? Date()

                        let item = UserVirtualPantry(id: id, itemName: itemName, expDate: expDate)
                        self.items.append(item)
                    }
                }
            }
        }
    }
    
    // Function 7: Delete document from firebase database
    func deleteItem(itemName: String) {
        if let uuid = self.uuid {
            let db = Firestore.firestore()
            let ref = db.collection("userCollection").document(uuid).collection("virtualPantry").document(itemName)
            ref.delete { error in
                if let error = error {
                    print("Error deleting item: \(error.localizedDescription)")
                } else {
                    print("Item deleted successfully")
                    self.items.removeAll(where: { $0.itemName == itemName })
                }
            }
        }
    }
    
    
    // Function 8: Add user's awards to firebase database
    func addAward(awardImg: String, awardDetailImg: String, photoImg: String, windowText: String, title: String, subtitle: String, body: String){
        let db = Firestore.firestore()
        
        let awardID = String(format: "%05d", Int.random(in: 0...99999)) // generating 5 digit random number

        let ref = db.collection("userCollection").document(self.uuid!).collection("awards").document(awardID)
        // what is inside the doccument
        ref.setData([
            "awardImg": awardImg,
            "awardDetailImg": awardDetailImg,
            "photoImg": photoImg,
            "windowText": windowText,
            "title": title,
            "subtitle": subtitle,
            "body": body
        ]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    
    // Function 9: Fetch user's awards from firestore database
    @Published var awards: [Award] = []
    
    func fetchAwards() {
        awards.removeAll()
        let db = Firestore.firestore()
        if let uuid = self.uuid {
            let ref = db.collection("userCollection").document(uuid).collection("awards") // change this
            ref.getDocuments { snapshot, error in
                guard error == nil else{
                    print(error!.localizedDescription)
                    return
                }

                if let snapshot = snapshot {
                    for document in snapshot.documents{
                        let data = document.data()
                        
                        let id = UUID().uuidString
                        let awardImg = data["awardImg"] as? String ?? ""
                        let awardDetailImg = data["awardDetailImg"] as? String ?? ""
                        let photoImg = data["photoImg"] as? String ?? ""
                        let windowText = data["windowText"] as? String ?? ""
                        let title = data["title"] as? String ?? ""
                        let subtitle = data["subtitle"] as? String ?? ""
                        let body = data["body"] as? String ?? ""

                        let award = Award(
                            id: id,
                            awardImg: awardImg,
                            awardDetailImg: awardDetailImg,
                            photoImg:photoImg,
                            windowText:windowText,
                            title:title,
                            subtitle:subtitle,
                            body:body
                        )
                        
                        self.awards.append(award)
                    }
                }
            }
        }
    }
    
    
}
