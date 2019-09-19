//
//  CardDetailViewController.swift
//  EKTP-Scanner
//
//  Created by Irfan Rafii Musyafa on 18/09/19.
//  Copyright © 2019 Irmusyafa. All rights reserved.
//

import UIKit

class CardDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    public var item: HistoryObject!
    private var extractedItems: [String?] = []
    private var sectionHeaders: [String] {
        return ["Images", "Surname", "First Name", "Surname at Birth", "ID Number", "Date of Birth", "Gender", "Signature", "Nationality", "Registration Date"]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        extractItems()
    }
    
    private func extractItems() {
        extractedItems = []
        extractedItems.insert(item.person?.sureName, at: 0)
        extractedItems.insert(item.person?.firstName, at: 1)
        extractedItems.insert(item.person?.sureNameBirthDate, at: 2)
        extractedItems.insert(item.person?.idNumber, at: 3)
        extractedItems.insert(Utility.getString(from: item.person?.birthdate), at: 4)
        extractedItems.insert(item.person?.gender?.description, at: 5)
        extractedItems.insert(item.person?.signature, at: 6)
        extractedItems.insert(item.person?.nationality, at: 7)
        extractedItems.insert(Utility.getString(from: item.date
        ), at: 8)
    }
}

extension CardDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionHeaders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0,
            let cell = tableView.dequeueReusableCell(withIdentifier: "image_cell") as? FullImageTableViewCell {
            cell.setup(item)
            return cell
        }
        if indexPath.row > 0,
            let cell = tableView.dequeueReusableCell(withIdentifier: "info_cell") as? CardDetailDataTableViewCell {
            cell.setup(title: sectionHeaders[indexPath.row], data: extractedItems[indexPath.row - 1])
            return cell
        }
        return UITableViewCell()
    }
}

extension CardDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.row == 0) ? tableView.frame.size.width * 2 / 3 : 90
    }
}
