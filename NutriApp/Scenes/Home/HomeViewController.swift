//
//  HomeCollectionViewController.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 02/01/21.
//

import UIKit

import RxSwift
import RxCocoa

private let reuseIdentifier = "RecipeCollectionViewCell"

class HomeViewController: UICollectionViewController {
    var homePresenter:HomePresenter!
    let disposeBag = DisposeBag()
    lazy var searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        homePresenter.recipes.asDriver().drive(onNext: { [weak self] _ in
            self?.collectionView.reloadData()
        }).disposed(by: disposeBag)
        
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
        
        searchController.searchBar.rx.text.orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .do(onNext: {text in
                print(text)
            })
            .bind(to: homePresenter.searchQuery)
            .disposed(by: disposeBag)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homePresenter.recipes.value.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RecipeCollectionViewCell
    
        let recipe = homePresenter.recipes.value[indexPath.row]
        cell.bindData(recipe: recipe)
        
        if homePresenter.recipes.value.count - 1 == indexPath.row {
            homePresenter.loadMoreTrigger.accept(searchController.searchBar.text ?? "")
        }
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homePresenter.selection.accept(indexPath.row)
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = view.frame.size.width * 0.45
        let height = width * 0.74 + 60
        return CGSize(width: width , height: height )
    }
}
