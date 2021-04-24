//
//  NationUtil.swift
//  LocalizationTools
//
//  Created by iDevFans on 16/9/1.
//  Copyright © 2016年 macdev. All rights reserved.
//

class NationUtil {
    
    class func nationFlagImageName(nationName: String) -> String {
        let nation = nationName.uppercased()
        if (nation == "ZH-HANS") {
            return "CN"
        }
        if (nation == "BASE") {
            return "US"
        }
        if (nation == "ZH") {
            return "CN"
        }
        if (nation == "CS") {
            return "CZ"
        }
        if (nation == "DA") {
            return "DK"
        }
        if (nation == "NB") {
            return "NO"
        }
        if (nation == "NB") {
            return "NO"
        }
        if (nation == "KO") {
            return "KP"
        }
        if (nation == "ZH-HANT") {
            return "TW"
        }
        if (nation == "JA") {
            return "JP"
        }
        if (nation == "PT-PT") {
            return "PT"
        }
        if (nation == "EN") {
            return "US"
        }
        if (nation == "EL") {
            return "GR"
        }
        if (nation == "ID1") {
            return "ID"
        }
        if (nation == "UK") {
            return "UA"
        }
        return nation
    }
}
