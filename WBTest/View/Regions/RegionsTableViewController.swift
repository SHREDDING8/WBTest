//
//  RegionsTableViewController.swift
//  WBTest
//
//  Created by SHREDDING on 23.09.2023.
//

import UIKit

class RegionsTableViewController: UITableViewController {
    
    var presenter:RegionsPresenterProtocol?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "Регионы"
        
        let cellNib = UINib(nibName: "RegionTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "RegionTableViewCell")
        
        let refreshController = UIRefreshControl()
        refreshController.addTarget(self, action: #selector(refreshRegions), for: .valueChanged)
        self.refreshControl = refreshController
        
        DispatchQueue.main.async {
            self.presenter?.loadRegions()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.getRegionsCount() ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegionTableViewCell", for: indexPath) as! RegionTableViewCell
        
        let region = presenter!.getRegion(index: indexPath.row)
        cell.configure(region: region)

        
        DispatchQueue.main.async {
            self.presenter?.getPhoto(url: region.imagesURls.first ?? "", completion: { image in
                DispatchQueue.main.async{
                    cell.regionImage.image = image
                }
            })
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVc = AppAssembly.createRegionDetailController(region: presenter!.getRegion(index: indexPath.row))
        self.navigationController?.pushViewController(detailVc, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    @objc func refreshRegions(){
        self.presenter?.loadRegions()
    }
}


extension RegionsTableViewController:RegionsViewProtocol{    
    func updateRegions() {
        self.tableView.reloadData()
    }
    
    func errorLoadRegions() {
        
    }
    
    func endRefreshing(){
        self.tableView.refreshControl?.endRefreshing()
    }
    
    
}
