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

    public var cardModel: CardModel!

    private var extractedItems: [String?] = []
    private var sectionHeaders: [String]!
    private let viewModel = CardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initiateData()
    }
    
    private func initiateData() {
        sectionHeaders = viewModel.headers
        extractedItems = viewModel.extractCardModel(cardModel: cardModel)
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
            cell.setup(cardModel)
            return cell
        }
        if indexPath.row > 0,
            let cell = tableView.dequeueReusableCell(withIdentifier: "info_cell") as? CardDetailDataTableViewCell {
            let title = sectionHeaders[indexPath.row].uppercased()
            let data = extractedItems[indexPath.row]?.uppercased()
            cell.setup(title: title, data: data)
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
