//
//  AddClientController+handleSave.swift
//  SaleApp
//
//  Created by logan on 2018/4/11.
//  Copyright © 2018 Chuanqi. All rights reserved.
//

import UIKit
import Firebase

extension AddClientController{
    @objc func handleSave(){
        guard let userId = Auth.auth().currentUser?.uid else { return }
        var randomName = ""
        
        if let key = currentClient?.key{
            randomName = key
        } else {
            randomName = UUID().uuidString
        }
        
        
        guard var newClient = getClientInfo() else { return }
        newClient.key = randomName
        newClient.profit = currentClient?.profit
        
        if let image = self.selectedImage{
            // changed image for existing client or added image for new clien
            saveClientImageToStorage(userId: userId, image: image, createdClient: newClient, randomName: randomName)
        } else{
            // image not changed or added
            if let imageUrl = currentClient?.image{
                // edit existing client
                newClient.image = imageUrl
                let value1 = ["name": newClient.name, "profileImageUrl": imageUrl, "key": newClient.key, "id": newClient.id, "phone": newClient.phone , "address": newClient.address, "profit": newClient.profit]
                addNewClientIntoDatabaseWithUID(userId, randomName: randomName, values: value1 as [String : AnyObject])
            } else {
                // add new client to database
                newClient.image = "None"
                let value2 = ["name": newClient.name, "profileImageUrl": "None", "key": newClient.key, "id": newClient.id, "phone": newClient.phone , "address": newClient.address, "profit": "0"]
                addNewClientIntoDatabaseWithUID(userId, randomName: randomName, values: value2 as [String : AnyObject])
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    private func getClientInfo() -> Client?{
        var newClient = Client()
        guard let name = nameTextField.text else {
            present(AlertCreator.shared.createAlertWithTitle(title: "Name can not be empty."), animated: true, completion: nil)
            return nil}
        if name.isEmpty{
            present(AlertCreator.shared.createAlertWithTitle(title: "Name can not be empty."), animated: true, completion: nil)
            return nil}
        newClient.name = name
        if let phone = phoneNumberTextField.text {
            newClient.phone = phone
        } else {
            newClient.phone = ""
        }
        if let id = idTextField.text {
            newClient.id = id
        } else {
            newClient.id = ""
        }
        if let clientAddress = addressTextView.text{
            newClient.address = clientAddress
        } else {
            newClient.address = ""
        }
        return newClient
    }
    
    private func saveClientImageToStorage(userId:String, image: UIImage, createdClient: Client, randomName: String){
        let storageRef = Storage.storage().reference().child("ClientImages").child(userId).child("\(randomName).jpg")
        if let uploadData = UIImageJPEGRepresentation(image, 0.1){
            storageRef.putData(uploadData, metadata: nil) { (metaData, error) in
                if error != nil{
                    print("Failed to save image to storge with error: \(error?.localizedDescription ?? "")")
                    return
                }
                if let profileImageURL = metaData?.downloadURL()?.absoluteString{
                    var profit = "0"
                    if let currentProfit = self.currentClient?.profit{
                        profit = currentProfit
                    }
                    
                    let values = ["name": createdClient.name, "profileImageUrl": profileImageURL, "key": createdClient.key, "id": createdClient.id, "phone": createdClient.phone , "address": createdClient.address, profit: profit]
                    self.addNewClientIntoDatabaseWithUID(userId, randomName: randomName, values: values as [String : AnyObject])
                }
            }
        }
    }
    
    private func addNewClientIntoDatabaseWithUID(_ uid: String, randomName: String, values: [String: AnyObject]) {
        let ref = Database.database().reference()
        let usersReference = ref.child("users").child(uid).child("Clients").child(randomName)
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            if err != nil {
                print(err!)
                return
            }
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }

}
