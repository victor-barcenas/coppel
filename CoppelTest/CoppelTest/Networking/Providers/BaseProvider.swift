//
//  BaseProvider.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 13/11/23.
//

import FirebaseFirestore

class BaseProvider {
    let db = Firestore.firestore()
    let settings = FirestoreSettings()
    
    init() {
        settings.cacheSettings =
        MemoryCacheSettings(garbageCollectorSettings: MemoryLRUGCSettings())
        // Use persistent disk cache, with 100 MB cache size
        settings.cacheSettings = PersistentCacheSettings(sizeBytes: 100 * 1024 * 1024 as NSNumber)
        db.settings = settings
    }
}

