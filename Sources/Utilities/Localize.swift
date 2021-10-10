//
//  Localize.swift
//  
//
//  Created by Geoff Burns on 10/10/21.
//

import Foundation


public protocol ILocalizationRepository {
    func get(_ phrase: String) -> String
}


public class LocalizationRegistry
{
    public static let shared = LocalizationRegistry()
    
    public var registry : [ILocalizationRepository] = []
    
    public func register(_ repo : ILocalizationRepository)
    {
        registry.append(repo)
    }
    public static func register(_ repo : ILocalizationRepository)
    {
        shared.register(repo)
    }
    public func get(_ phrase: String) -> String
    {
        let localisationFromMainBundle = NSLocalizedString(phrase,
                                                            tableName: nil,
                                                            bundle: .main,
                                                            value: "",
                                                            comment: "")
         
        if localisationFromMainBundle != phrase
        {
            return localisationFromMainBundle
        }
        for  repo in registry
        {
            let localisationFromModuleBundle = repo.get(phrase)
            
            if localisationFromModuleBundle != phrase
            {
                return localisationFromModuleBundle
            }
        }
        return phrase
    }
    
    public static func get(_ phrase: String) -> String
    {
        return shared.get(phrase)
    }
}
