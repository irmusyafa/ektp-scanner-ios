//
//  CardListViewController.swift
//  EKTP-Scanner
//
//  Created by Irfan Rafii Musyafa on 18/09/19.
//  Copyright © 2019 Irmusyafa. All rights reserved.
//

import UIKit

class CardListViewController: UIViewController {
    private let viewModel = HistoryViewModel()
    private var history: [HistoryObject]?
    private var selectedItem: HistoryObject!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initiateView()
        loadHistory()
    }
    
    private func initiateView() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func loadHistory() {
        history = viewModel.getHistory()
        table.reloadData()
    }
    
    @IBAction func captureButton(_ sender: UIButton) {
        performSegue(withIdentifier: "capture", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CardDetailViewController {
            destination.item = selectedItem
        }
    }
}

extension CardListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "history_cell") as? CardTableViewCell else { return UITableViewCell() }
        cell.setup(history?[indexPath.row])
        
        return cell
    }
}

extension CardListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.selectedItem = history?[indexPath.row]
        performSegue(withIdentifier: "show", sender: self)
    }
}
