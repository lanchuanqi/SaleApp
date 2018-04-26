//
//  AddDealController+handleSave.swift
//  SaleApp
//
//  Created by logan on 2018/4/11.
//  Copyright © 2018 Chuanqi. All rights reserved.
//

import UIKit
import Firebase


extension AddDealController{
    @objc func handleSave(){
        guard let deal = getDealInfoFromUser() else { return }
        guard let clientKey = client?.key else { return }
        guard let dealKey = deal.key else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        //let newTotalProfit = caculateNewTotalProfit(newDeal: deal)
        
        if let image = self.selectedImage{
            saveDealImageToStorage(userId: uid, image: image, deal: deal, dealkey: dealKey, clientKey: clientKey)
        } else {
            let value = ["name": deal.name, "price": deal.price, "sellPrice": deal.sellPrice, "shipNumber": deal.shipNumber, "shipped": deal.shipped, "date": deal.date, "key": deal.key, "image": deal.image, "profit": deal.profit] as [String : AnyObject]
            saveDealToDatabase(uid: uid, clientKey: clientKey, dealKey: dealKey, value: value)
        }
    }
    
    
    
    private func saveDealImageToStorage(userId:String, image: UIImage, deal: Deal, dealkey: String, clientKey: String){
        let storageRef = Storage.storage().reference().child("DealImages").child(userId).child("\(dealkey).jpg")
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        if let uploadData = UIImageJPEGRepresentation(image, 0.1){
            storageRef.putData(uploadData, metadata: nil) { (metaData, error) in
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                if error != nil{
                    print("Failed to save image to storge with error: \(error?.localizedDescription ?? "")")
                    return
                }
                if let profileImageURL = metaData?.downloadURL()?.absoluteString{
                    let value = ["name": deal.name, "price": deal.price, "sellPrice": deal.sellPrice, "shipNumber": deal.shipNumber, "shipped": deal.shipped, "date": deal.date, "key": deal.key, "image": profileImageURL, "profit": deal.profit] as [String : AnyObject]
                    self.saveDealToDatabase(uid: userId, clientKey: clientKey, dealKey: dealkey, value: value)
                }
            }
        }
    }
    
    
    
    private func saveDealToDatabase(uid: String, clientKey: String, dealKey: String, value: [String:AnyObject]){
        let ref = Database.database().reference()
        let dealsReference = ref.child("users").child(uid).child("deals").child(clientKey).child(dealKey)
        dealsReference.updateChildValues(value) { (error, ref) in
            if error != nil{
                DispatchQueue.main.async {
                    self.present(AlertCreator.shared.createAlertWithTitle(title: "Failed to save deal with error: \(error?.localizedDescription ?? "")"), animated: true, completion: nil)
                }
                return
            }
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    private func getDealInfoFromUser() -> Deal?{
        guard let name = nameTextField.text else {
            present(AlertCreator.shared.createAlertWithTitle(title: "Can't save without product name."), animated: true, completion: nil)
            return nil
        }
        if name == ""{
            present(AlertCreator.shared.createAlertWithTitle(title: "Can't save without product name."), animated: true, completion: nil)
            return nil
        }
        guard let price = priceTextField.text, let sellPrice = sellPriceTextField.text else {
            present(AlertCreator.shared.createAlertWithTitle(title: "Price or sell price can not be empty."), animated: true, completion: nil)
            return nil
        }
        guard let dealPrice = Double(price), let dealSellPrice = Double(sellPrice) else {
            present(AlertCreator.shared.createAlertWithTitle(title: "Price or sell price are bad formatted."), animated: true, completion: nil)
            return nil
        }
        
        var newDeal = Deal()
        newDeal.name = name
        newDeal.price = String(dealPrice)
        newDeal.sellPrice = String(dealSellPrice)
        newDeal.profit = String(dealSellPrice - dealPrice)
        newDeal.shipNumber = shippingTextField.text
        newDeal.shipped = String(shippedSwitch.isOn.hashValue)
        if let edittedDeal = self.deal{
            newDeal.key = edittedDeal.key
            newDeal.image = edittedDeal.image
        } else {
            newDeal.key = UUID().uuidString
            newDeal.image = "None"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        newDeal.date = dateFormatter.string(from: Date())
        return newDeal
    }
    
//    private func caculateNewTotalProfit(newDeal: Deal) -> Double{
//        var profitDifference = 0.0
//        var newProfitTotal = 0.0
//        if let existDeal = self.deal{
//            if let oldProfit = existDeal.profit, let newProfit = newDeal.profit{
//                if let oldProfitInt = Double(oldProfit), let newProfitInt = Double(newProfit){
//                    profitDifference = newProfitInt - oldProfitInt
//                }
//            }
//        } else {
//            //new deal, add new profit
//            if let profit = newDeal.profit{
//                if let profitInt = Double(profit){
//                    profitDifference = profitInt
//                }
//            }
//        }
//        let oldProfitString = getCurrentClientTotalProfit()
//        if let oldTotal = Double(oldProfitString){
//            print(oldTotal)
//            newProfitTotal = oldTotal + profitDifference
//        }
//
//        return newProfitTotal
//    }
//
//
//    private func getCurrentClientTotalProfit() -> String{
//        guard let userId = Auth.auth().currentUser?.uid else { return "0" }
//        guard let clientKey = client?.key else { return "0" }
//        let ref = Database.database().reference()
//        ref.child("users").child(userId).child("Clients").child(clientKey).observeSingleEvent(of: .value , with: { (snapshot) in
//
//
//
//
//        })
//        return "0"
//    }
//
//    private func updateTotalProfitOnClient(totalProfit: Double){
//        guard let userId = Auth.auth().currentUser?.uid else { return }
//        guard let clientKey = client?.key else { return }
//        if let selectedClient = client{
//            let values = ["name": selectedClient.name, "profileImageUrl": selectedClient.image, "key": selectedClient.key, "id": selectedClient.id, "phone": selectedClient.phone , "address": selectedClient.address, "profit": String(totalProfit)] as [String : AnyObject]
//            let ref = Database.database().reference()
//            ref.child("users").child(userId).child("Clients").child(clientKey).updateChildValues(values)
//        }
//    }

    
    
}
