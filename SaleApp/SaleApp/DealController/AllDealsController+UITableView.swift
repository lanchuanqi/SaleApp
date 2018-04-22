//
//  AllDealsController+UITableView.swift
//  SaleApp
//
//  Created by logan on 2018/4/12.
//  Copyright © 2018 Chuanqi. All rights reserved.
//

import UIKit
class IndentedLabel: UILabel{
    override func draw(_ rect: CGRect) {
        let insert = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        let customeRect = UIEdgeInsetsInsetRect(rect, insert)
        super.drawText(in: customeRect)
    }
}


extension AllDealsController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = IndentedLabel()
        label.text = headerName[section]
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.darkBlue
        label.backgroundColor = UIColor.lightBlue
        return label
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return self.deals.count
        } else {
            return self.finishedDeal.count
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! DealsCell
        var deal = Deal()
        if indexPath.section == 0{
            deal = deals[indexPath.row]
        } else {
            deal = finishedDeal[indexPath.row]
        }
        cell.deal = deal
        if let imageUrl = deal.image {
            if imageUrl != "None"{
                cell.dealImageView.downLoadAndCacheImageFromURL(urlString: imageUrl)
            } else {
                cell.dealImageView.image = #imageLiteral(resourceName: "select_photo_empty")
            }
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var deal = Deal()
        if indexPath.section == 0{
            deal = deals[indexPath.row]
        } else {
            deal = finishedDeal[indexPath.row]
        }
        let addDealVC = AddDealController()
        addDealVC.deal = deal
        addDealVC.client = client
        present(CustomeNavigationController(rootViewController: addDealVC), animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: performDeleteRowAction)
        let editAction = UITableViewRowAction(style: .normal, title: "Track", handler: performEditAction)
        
        //deleteAction.backgroundColor = UIColor.lightRed
        editAction.backgroundColor = UIColor.darkBlue
        return [editAction]
    }
    
    //    private func performDeleteRowAction(action: UITableViewRowAction, indexPath: IndexPath){
    //        let company = self.companies[indexPath.row]
    //        print("Attempting delete company at row \(indexPath.row) with name \(String(describing: company.name))")
    //        // delete companies from tableView
    //        self.companies.remove(at: indexPath.row)
    //        self.tableView.deleteRows(at: [indexPath], with: .bottom)
    //
    //        //delete companies from CoreData
    //        let context = CoreDataManager.shared.persistentContainer.viewContext
    //        context.delete(company)
    //        do{
    //            try context.save()
    //        } catch let saveError{
    //            print("Delete from CoreData failed with error: \(saveError)")
    //        }
    //    }
    
    private func performEditAction(action: UITableViewRowAction, indexPath: IndexPath){
        print("tracking...")
    }
    
}
