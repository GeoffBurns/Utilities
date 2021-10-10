//
//  BundleRegistry.swift
//  
//
//  Created by Geoff Burns  on 10/10/21.
//

import Foundation

public protocol IBundleRepository {
    func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy , keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy ) -> T?
}


public class BundleRegistry
{
    public static let shared = BundleRegistry()
    
    public var registry : [IBundleRepository] = []
    
    public func register(_ repo : IBundleRepository)
    {
        registry.append(repo)
    }
    func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T?
    {
    
        if let decodedFromMainBundle =
            Bundle.main.tryDecode(T.self, from: file, dateDecodingStrategy: dateDecodingStrategy,keyDecodingStrategy: keyDecodingStrategy)
        {
            return decodedFromMainBundle
        }
          
        for  repo in registry
        {
            if let decodedFromModuleBundle = repo.decode(T.self, from: file, dateDecodingStrategy: dateDecodingStrategy,keyDecodingStrategy: keyDecodingStrategy)
            
            {
                return decodedFromModuleBundle
            }
        }
        return nil
    }
}
