//
//  LocaleDataSource.swift
//  NutriApp
//
//  Created by Fahim Jatmiko on 31/12/20.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

protocol LocaleDataSourceProtocol: class {
    func getRecipes(query:String) -> Observable<[RecipeRLM]>
    func getFavoritedRecipes() -> Observable<[RecipeRLM]>
    
    //generic object
    func getObjects<T: Object>(_ type: T.Type, predicate: String?) -> Observable<[T]>
    func getObject<T: Object, KeyType>(_ type: T.Type, key: KeyType) -> Observable<T?>
    func add<T: Object>(_ data: T, update: Bool) -> Observable<T>
    func add<T: Object>(_ data: [T], update: Bool) -> Observable<[T]>
    func delete<T: Object>(_ data: T) -> Observable<Void>
    func delete<T: Object>(_ data: [T]) -> Observable<Void>
    func clearAllData() -> Observable<Void>
//    func getRecipeDetails(id:Int) -> Observable<Recipe>
}

enum DatabaseError: LocalizedError {

  case invalidInstance
  case requestFailed
  
  var errorDescription: String? {
    switch self {
    case .invalidInstance: return "Database can't instance."
    case .requestFailed: return "Your request failed."
    }
  }

}

final class LocaleDataSource : LocaleDataSourceProtocol {
    private let realm: Realm?
    
    private init(realm: Realm) {
        self.realm = realm
    }
    
    static let createInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
        return LocaleDataSource(realm: realmDatabase!)
    }
    
    func add<T: Object>(_ data: T, update: Bool = true) -> Observable<T> {
        return add([data]).map{$0.first!}
    }
    
    func add<T: Object>(_ data: [T], update: Bool = true) -> Observable<[T]> {
        return Observable<[T]>.create { observer in
            if let realm = self.realm {
                try? realm.write {
                    realm.add(data, update: .modified)
                }
                observer.onNext(data)
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func delete<T: Object>(_ data: [T]) -> Observable<Void> {
        return Observable<Void>.create { observer in
            if let realm = self.realm {
                try? realm.write {
                    realm.delete(data)
                }
                observer.onNext(())
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func delete<T: Object>(_ data: T) -> Observable<Void> {
        return delete([data])
    }
    
    func clearAllData() -> Observable<Void> {
        return Observable<Void>.create { observer in
            if let realm = self.realm {
                try? realm.write {
                    realm.deleteAll()
                }
                observer.onNext(())
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func getObjects<T: Object>(_ type: T.Type, predicate: String? = nil) -> Observable<[T]> {
        guard let realm = realm else {
            return Observable<[T]>.create { observer in
                observer.onError(DatabaseError.invalidInstance)
                return Disposables.create()
            }
        }
        
        let objects = predicate == nil ? realm.objects(T.self) : realm.objects(T.self).filter(predicate!)
        return Observable.array(from: objects)
    }
    
    func getObject<T: Object, KeyType>(_ type: T.Type, key: KeyType) -> Observable<T?> {
        guard let realm = realm else {
            return Observable<T?>.create { observer in
                observer.onError(DatabaseError.invalidInstance)
                return Disposables.create()
            }
        }
        
        return Observable<T?>.create { observer in
            
            let object = realm.object(ofType: type, forPrimaryKey: key)
            observer.onNext(object)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func getFavoritedRecipes() -> Observable<[RecipeRLM]> {
        guard let realm = realm else {
            return Observable<[RecipeRLM]>.create { observer in
                observer.onError(DatabaseError.invalidInstance)
                return Disposables.create()
            }
        }
        
        let objects = realm.objects(RecipeRLM.self).filter("isFavorite = true")
        return Observable.array(from: objects)
    }
    
    func getRecipes(query:String) -> Observable<[RecipeRLM]> {
        guard let realm = realm else {
            return Observable<[RecipeRLM]>.create { observer in
                observer.onError(DatabaseError.invalidInstance)
                return Disposables.create()
            }
        }
        
        let objects = query.isEmpty ? realm.objects(RecipeRLM.self) : realm.objects(RecipeRLM.self).filter("title contains[c] '\(query)'")
        return Observable.array(from: objects)
    }
}
