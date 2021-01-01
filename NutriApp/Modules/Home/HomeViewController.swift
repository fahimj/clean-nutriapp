//
//  HomeViewController.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 01/01/21.
//

import UIKit
import RxSwift

class HomeViewController: UITableViewController {
    var homePresenter:HomePresenter!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false
        
        homePresenter.loadTrigger.accept(())
        homePresenter.recipes.subscribe(onNext: {[weak self] _ in
            self?.tableView.reloadData()
        }, onError: {error in
            
        }).disposed(by: disposeBag)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if homePresenter.recipes.value.count == 0 {
            homePresenter.loadMoreTrigger.accept(())
        }
        
        return homePresenter.recipes.value.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell

        // Configure the cell...
        let recipe = homePresenter.recipes.value[indexPath.row]
        cell.bindData(recipe: recipe)
        
        //load more if it is last cell
        if homePresenter.recipes.value.count == indexPath.row - 1{
            homePresenter.loadMoreTrigger.accept(())
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        homePresenter.selection.accept(indexPath.row)
    }

}
