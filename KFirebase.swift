//
//  Created by K&
//  kenanatmaca.com
//  Copyright © 2016 Kenan Atmaca. All rights reserved.
//  KFirebase v1.0
//

import UIKit
import SystemConfiguration
import Firebase

open class KFirebase: NSObject {
    
    private static var url:String?
    private static var storageURL:String?

     @discardableResult
    open class func connect(referanceURL:String? = nil,storageUrl:String? = nil) -> KFirebase.Type {
    
        url = referanceURL
        storageURL = storageUrl
    
        return KFirebase.self
    }
    
    // NET CONNECTİON CONTROL
    
    open class func isConnected() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired
        
        return isReachable && !needsConnection
        
    }
    
    // INSERT SERVER [:]
    
     @discardableResult
    open class func insert(values:[String:AnyObject],childs:[String],completion:((_ state:Bool) -> ())? = nil) -> KFirebase.Type {
      
         let referanceDB:FIRDatabaseReference! = url != nil ? FIRDatabase.database().reference(fromURL: self.url!) : FIRDatabase.database().reference()
            var chlds:FIRDatabaseReference!
            
            switch (childs.count) {
            case 1: chlds = referanceDB.child(childs[0])
            case 2: chlds = referanceDB.child(childs[0]).child(childs[1])
            case 3: chlds = referanceDB.child(childs[0]).child(childs[1]).child(childs[2])
            case 4: chlds = referanceDB.child(childs[0]).child(childs[1]).child(childs[2]).child(childs[3])
            default: fatalError("@Child count maximum 4")
            }
          
            chlds.setValue(values, withCompletionBlock: { (error, ref) in
                if error != nil {
                    print(error!)
                    if completion != nil {completion!(false)}
                    return
                }
                
                if completion != nil {completion!(true)}
            })
      
   
        return KFirebase.self
    }
    
    // INSERT SERVER
    
    @discardableResult
    open class func insert(value:String,childs:[String],completion:((_ state:Bool) -> ())? = nil) -> KFirebase.Type {
        
        let referanceDB:FIRDatabaseReference! = url != nil ? FIRDatabase.database().reference(fromURL: self.url!) : FIRDatabase.database().reference()
        var chlds:FIRDatabaseReference!
        
        switch (childs.count) {
        case 1: chlds = referanceDB.child(childs[0])
        case 2: chlds = referanceDB.child(childs[0]).child(childs[1])
        case 3: chlds = referanceDB.child(childs[0]).child(childs[1]).child(childs[2])
        case 4: chlds = referanceDB.child(childs[0]).child(childs[1]).child(childs[2]).child(childs[3])
        default: fatalError("@Child count maximum 4")
        }
        
        chlds.setValue(value, withCompletionBlock: { (error, ref) in
            if error != nil {
                print(error!)
                if completion != nil {completion!(false)}
                return
            }
            
            if completion != nil {completion!(true)}
        })
        
        
        return KFirebase.self
    }
    
    
    // UPDATE SERVER
    
     @discardableResult
    open class func update(values:[String:AnyObject],childs:[String],completion:((_ state:Bool) -> ())? = nil) -> KFirebase.Type {
        
        
           let referanceDB:FIRDatabaseReference! = url != nil ? FIRDatabase.database().reference(fromURL: self.url!) : FIRDatabase.database().reference()
            var chlds:FIRDatabaseReference!
            
            switch (childs.count) {
            case 1: chlds = referanceDB.child(childs[0])
            case 2: chlds = referanceDB.child(childs[0]).child(childs[1])
            case 3: chlds = referanceDB.child(childs[0]).child(childs[1]).child(childs[2])
            case 4: chlds = referanceDB.child(childs[0]).child(childs[1]).child(childs[2]).child(childs[3])
            default: fatalError("@Child count maximum 4")
            }
            
            chlds.updateChildValues(values, withCompletionBlock: { (error, ref) in
                if error != nil {
                    print(error!)
                    if completion != nil {completion!(false)}
                    return
                }
                
                if completion != nil {completion!(true)}
            })
       
        
        return KFirebase.self
    }
    
    // REMOVE CHİLD SERVER
    
     @discardableResult
    open class func remove(childs:[String],completion:((_ state:Bool) -> ())? = nil) -> KFirebase.Type {
        
           let referanceDB:FIRDatabaseReference! = url != nil ? FIRDatabase.database().reference(fromURL: self.url!) : FIRDatabase.database().reference()
            var chlds:FIRDatabaseReference!
            
            switch (childs.count) {
            case 1: chlds = referanceDB.child(childs[0])
            case 2: chlds = referanceDB.child(childs[0]).child(childs[1])
            case 3: chlds = referanceDB.child(childs[0]).child(childs[1]).child(childs[2])
            case 4: chlds = referanceDB.child(childs[0]).child(childs[1]).child(childs[2]).child(childs[3])
            default: fatalError("@Child count maximum 4")
            }
           
            chlds.removeValue(completionBlock: { (error, ref) in
                
                if error != nil {
                    print(error!)
                    if completion != nil {completion!(false)}
                    return
                }
                
                if completion != nil {completion!(true)}
                
            })
        
        return KFirebase.self
    }
    
    // OBSERVE SERVER
    
   @discardableResult
    open class func observe(childs:[String],event:FIRDataEventType,completion:@escaping (_ data:[String:AnyObject]) -> ()) -> KFirebase.Type {
    
    let referanceDB:FIRDatabaseReference! = url != nil ? FIRDatabase.database().reference(fromURL: self.url!) : FIRDatabase.database().reference()
    var chlds:FIRDatabaseReference!
    
    switch (childs.count) {
    case 1: chlds = referanceDB.child(childs[0])
    case 2: chlds = referanceDB.child(childs[0]).child(childs[1])
    case 3: chlds = referanceDB.child(childs[0]).child(childs[1]).child(childs[2])
    case 4: chlds = referanceDB.child(childs[0]).child(childs[1]).child(childs[2]).child(childs[3])
    default: fatalError("@Child count maximum 4")
    }
    
    chlds.observe(event, with: { (snapshot) in
        
        if let sdata:[String:AnyObject] = snapshot.value as? [String:AnyObject] {
            
            completion(sdata)
            
        }
        
        
    })
    
        return KFirebase.self
    }
    
    // OBSERVE SERVER SİNGULAR VALUE
    
  @discardableResult
    open class func observeSingularValue(childs:[String],event:FIRDataEventType,completion:@escaping (_ data:String) -> ()) -> KFirebase.Type {
        
        let referanceDB:FIRDatabaseReference! = url != nil ? FIRDatabase.database().reference(fromURL: self.url!) : FIRDatabase.database().reference()
        var chlds:FIRDatabaseReference!
        
        switch (childs.count) {
        case 1: chlds = referanceDB.child(childs[0])
        case 2: chlds = referanceDB.child(childs[0]).child(childs[1])
        case 3: chlds = referanceDB.child(childs[0]).child(childs[1]).child(childs[2])
        case 4: chlds = referanceDB.child(childs[0]).child(childs[1]).child(childs[2]).child(childs[3])
        default: fatalError("@Child count maximum 4")
        }
        
        chlds.observe(event, with: { (snapshot) in
            
            if let sdata:String = snapshot.value as? String {
                
                completion(sdata)
                
            }

        })
        
        return KFirebase.self
    }
    
    // SİNGLE OBSERVE SERVER
    
   @discardableResult
    open class func observeSingle(childs:[String],event:FIRDataEventType,completion:@escaping (_ data:[String:AnyObject]) -> ()) -> KFirebase.Type {
        
        let referanceDB:FIRDatabaseReference! = url != nil ? FIRDatabase.database().reference(fromURL: self.url!) : FIRDatabase.database().reference()
        var chlds:FIRDatabaseReference!
        
        switch (childs.count) {
        case 1: chlds = referanceDB.child(childs[0])
        case 2: chlds = referanceDB.child(childs[0]).child(childs[1])
        case 3: chlds = referanceDB.child(childs[0]).child(childs[1]).child(childs[2])
        case 4: chlds = referanceDB.child(childs[0]).child(childs[1]).child(childs[2]).child(childs[3])
        default: fatalError("@Child count maximum 4")
        }
        
        chlds.observeSingleEvent(of: event, with: { (snapshot) in
            if let sdata:[String:AnyObject] = snapshot.value as? [String:AnyObject] {
                
                completion(sdata)
                
            }
        })
        
        return KFirebase.self
    }
    
    // İNSERT PİCTURE
    
    @discardableResult
    open class func insertPicture(image:UIImage,childs:[String],completion:((_ state:Bool,_ imageURL:String?) -> ())? = nil) -> KFirebase.Type {
        
        let imageData = UIImageJPEGRepresentation(image, 0.1)
        
        let referanceDB = storageURL != nil ? FIRStorage.storage().reference(forURL: storageURL!) : FIRStorage.storage().reference()
        var chlds:FIRStorageReference!
        
        switch (childs.count) {
        case 1: chlds = referanceDB.child(childs[0])
        case 2: chlds = referanceDB.child(childs[0]).child(childs[1])
        case 3: chlds = referanceDB.child(childs[0]).child(childs[1]).child(childs[2])
        case 4: chlds = referanceDB.child(childs[0]).child(childs[1]).child(childs[2]).child(childs[3])
        default: fatalError("@Child count maximum 4")
        }
        
        chlds.put(imageData!, metadata: nil) { (metaData, error) in
            
            if error != nil {
                if completion != nil {completion!(false,nil)}
               print(error!)
                return
            }
            
            let imageURL = metaData?.downloadURL()?.absoluteString
            
                if completion != nil {completion!(true,imageURL!) }
        }
        
        
        return KFirebase.self
    }
    
     // DELETE PİCTURE
    
   @discardableResult
    open class func removePicture(childs:[String],completion:((_ state:Bool)->())? = nil) -> KFirebase.Type {
    
    let referanceDB = storageURL != nil ? FIRStorage.storage().reference(forURL: storageURL!) : FIRStorage.storage().reference()
    var chlds:FIRStorageReference!
    
    switch (childs.count) {
    case 1: chlds = referanceDB.child(childs[0])
    case 2: chlds = referanceDB.child(childs[0]).child(childs[1])
    case 3: chlds = referanceDB.child(childs[0]).child(childs[1]).child(childs[2])
    case 4: chlds = referanceDB.child(childs[0]).child(childs[1]).child(childs[2]).child(childs[3])
    default: fatalError("@Child count maximum 4")
    }
    
     chlds.delete { (error) in
        
        if error != nil {
            print(error!)
            if completion != nil {completion!(false)}
            return
        }
        
        if completion != nil {completion!(true)}
    }
    
     return KFirebase.self
    
    }
    
    // INSERT DATA
    
  @discardableResult
    open class func insertData(data:Data,childs:[String],completion:((_ state:Bool,_ dataURL:String?) -> ())? = nil) -> KFirebase.Type {
     
        let referanceDB = storageURL != nil ? FIRStorage.storage().reference(forURL: storageURL!) : FIRStorage.storage().reference()
        var chlds:FIRStorageReference!
        
        switch (childs.count) {
        case 1: chlds = referanceDB.child(childs[0])
        case 2: chlds = referanceDB.child(childs[0]).child(childs[1])
        case 3: chlds = referanceDB.child(childs[0]).child(childs[1]).child(childs[2])
        case 4: chlds = referanceDB.child(childs[0]).child(childs[1]).child(childs[2]).child(childs[3])
        default: fatalError("@Child count maximum 4")
        }
        
        chlds.put(data, metadata: nil) { (metaData, error) in
            
            if error != nil {
                if completion != nil {completion!(false,nil)}
                print(error!)
                return
            }
            
            let dataURL = metaData?.downloadURL()?.absoluteString
            
            if completion != nil {completion!(true,dataURL!) }
        }
        
        
        return KFirebase.self
    }
   
}//
