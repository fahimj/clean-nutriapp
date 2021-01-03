//
//  FavoriteViewController.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 02/01/21.
//

import UIKit

import RxSwift
private let reuseIdentifier = "RecipeCollectionViewCell"

class FavoriteViewController: UICollectionViewController {
    var favoritePresenter:FavoritePresenter!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        favoritePresenter.loadTrigger.accept(())
        favoritePresenter.recipes.asDriver().drive(onNext: { [weak self] _ in
            self?.collectionView.reloadData()
        }).disposed(by: disposeBag)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritePresenter.recipes.value.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RecipeCollectionViewCell
    
        let recipe = favoritePresenter.recipes.value[indexPath.row]
        cell.bindData(recipe: recipe)
            
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        favoritePresenter.selection.accept(indexPath.row)
    }

}

extension FavoriteViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = view.frame.size.width * 0.45
        let height = width * 0.74 + 60
        return CGSize(width: width , height: height )
    }
}
