//
//  SSPurchase.swift
//  mas-cli
//
//  Created by Andrew Naylor on 25/08/2015.
//  Copyright (c) 2015 Andrew Naylor. All rights reserved.
//

import CommerceKit
import StoreFoundation

typealias SSPurchaseCompletion =
    (_ purchase: SSPurchase?, _ completed: Bool, _ error: Error?, _ response: SSPurchaseResponse?) -> Void

extension SSPurchase {
    convenience init(adamId: UInt64, account: ISStoreAccount) {
        self.init()
        buyParameters =
            "productType=C&price=0&salableAdamId=\(adamId)&pricingParameters=STDRDL&pg=default&appExtVrsId=0"
        itemIdentifier = adamId
        accountIdentifier = account.dsID
        appleID = account.identifier

        let downloadMetadata = SSDownloadMetadata()
        downloadMetadata.kind = "software"
        downloadMetadata.itemIdentifier = adamId

        self.downloadMetadata = downloadMetadata
    }

    func perform(_ completion: @escaping SSPurchaseCompletion) {
        CKPurchaseController.shared().perform(self, withOptions: 0, completionHandler: completion)
    }
}
