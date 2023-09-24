//
//  FavouritesViewController.swift
//  WBTest
//
//  Created by SHREDDING on 24.09.2023.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    var presenter:FavouritesRegionsPresenterProtocol?

    @IBOutlet weak var favouritesTableView: UITableView!{
        didSet{
            let refreshControll = UIRefreshControl()
            refreshControll.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
            favouritesTableView.refreshControl = refreshControll
            let cellNib = UINib(nibName: "RegionTableViewCell", bundle: nil)
            favouritesTableView.register(cellNib, forCellReuseIdentifier: "RegionTableViewCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Избранное"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.favouritesTableView.reloadData()
    }
    
    @objc func refreshTableView(){
        self.favouritesTableView.reloadData()
        self.favouritesTableView.refreshControl?.endRefreshing()
    }


}

extension FavouritesViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.getRegionsCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegionTableViewCell", for: indexPath) as! RegionTableViewCell
        
        let region = presenter!.getRegion(index: indexPath.row)
        cell.configure(region: region)
        
        cell.doAfterClickLike = { isLiked in
            
            if !isLiked{
                self.favouritesTableView.reloadData()
                
            }
            
        }
        
        DispatchQueue.main.async {
            self.presenter?.getPhoto(url: region.imagesURls.first ?? "", completion: { image in
                DispatchQueue.main.async{
                    cell.regionImage.image = image
                }
            })
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVc = AppAssembly.createRegionDetailController(region: presenter!.getRegion(index: indexPath.row))
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
    
}

extension FavouritesViewController:FavouritesViewProtocol{
    
}
