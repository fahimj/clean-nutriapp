////
////  Injection.swift
////  NutriApp
////
////  Created by Fahim Jatmiko on 31/12/20.
////
//
//import Foundation
//import RealmSwift
//
//final class Injection: NSObject {
//  
//  private func provideRepository() -> MealRepositoryProtocol {
//    let realm = try? Realm()
//
//    let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
//    let remote: RemoteDataSource = RemoteDataSource.sharedInstance
//
//    return MealRepository.sharedInstance(locale, remote)
//  }
//
//  func provideHome() -> HomeUseCase {
//    let repository = provideRepository()
//    return HomeInteractor(repository: repository)
//  }
//
//  func provideDetail(category: CategoryModel) -> DetailUseCase {
//    let repository = provideRepository()
//    return DetailInteractor(repository: repository, category: category)
//  }
//
//}
