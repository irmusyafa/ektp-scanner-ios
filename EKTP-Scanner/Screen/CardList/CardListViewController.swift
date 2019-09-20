//
//  CardListViewController.swift
//  EKTP-Scanner
//
//  Created by Irfan Rafii Musyafa on 18/09/19.
//  Copyright © 2019 Irmusyafa. All rights reserved.
//

import UIKit

class CardListViewController: UIViewController {
    private let viewModel = CardViewModel()
    private var card: [CardModel]?
    private var selectedCardModel: CardModel!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initiateView()
        loadCard()
    }
    
    private func initiateView() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func loadCard() {
        card = viewModel.getCard()
        table.reloadData()
    }
    
    @IBAction func captureButton(_ sender: UIButton) {
        performSegue(withIdentifier: "capture", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CardDetailViewController {
            destination.cardModel = selectedCardModel
        }
    }
}

extension CardListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return card?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "card_cell") as? CardTableViewCell else { return UITableViewCell() }
        cell.setup(card?[indexPath.row])
        
        return cell
    }
}

extension CardListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.selectedCardModel = card?[indexPath.row]
        performSegue(withIdentifier: "show", sender: self)
    }
}
