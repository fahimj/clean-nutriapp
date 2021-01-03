//
//  RecipeDetailsViewController.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 02/01/21.
//

import UIKit
import RxSwift

class RecipeDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var favoriteSwitch: UISwitch!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var directionTextView: UITextView!
    
    var presenter: RecipeDetailsPresenter!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }
    
    private func setupRx() {
        presenter.imageUrl
            .map{(URL.init(string: $0) ?? URL.init(string: "https://via.placeholder.com/150")!)}
            .subscribe(onNext: {[weak self] url in
                self?.imageView.af.setImage(withURL: url)
            }, onError: {error in
                print("error happened")
            })
            .disposed(by: disposeBag)
        
        presenter.isFavorite
            .bind(to: favoriteSwitch.rx.isOn)
            .disposed(by: disposeBag)
        
        favoriteSwitch.rx.isOn
            .skip(1)
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .bind(to: presenter.isFavorite)
            .disposed(by: disposeBag)
        
        presenter.title
            .bind(to: titleLabel.rx.text).disposed(by: disposeBag)
        
        presenter.summary
            .map{$0.htmlAttributedString()}
            .bind(to: descriptionTextView.rx.attributedText)
            .disposed(by: disposeBag)
        
        presenter.ingredients
            .bind(to: ingredientsLabel.rx.text)
            .disposed(by: disposeBag)
        
        presenter.instructions
            .map{$0.htmlAttributedString()}
            .bind(to: directionTextView.rx.attributedText).disposed(by: disposeBag)
    }

}
