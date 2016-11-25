# KFirebase
İOS Google Firebase Easy Swift Class

KFirebase is easy for you, Firebase server provides file or data exchange.

- Set value in Firebase server

```Swift
  KFirebase.connect().insert(value: "hii", childs: ["msg"]) { (state) in
            if state {
                // success
            } else {
                // failed
            }
        }
```

- Update value in Firebase server

```Swift
let values = ["name":"john","age":"23"]
   
KFirebase.connect().update(values: values as [String : AnyObject], childs: ["users"]) { (state) in
       if state {
           // success
          } else {
                // failed
            }
        }
```

- Remove child in Firebase server

```Swift
  KFirebase.connect().remove(childs: ["msgs"])
```

- Observe value in Firebase server

```Swift
  KFirebase.connect().observe(childs: ["messages"], event: .value) { (data) in
            print(data) // [String:AnyObject]
        }
        
   // or
  
  KFirebase.connect().observeSingularValue(childs: ["links"], event: .value) { (data) in
            print(data) // String
        }
```

- Set images in your Firebase storage

```Swift
    let img = UIImage(named:"img.jpg")
        
    KFirebase.connect().insertPicture(image: img!, childs: ["img","profile.jpg"]) { (state, url) in
        if state {
            // success
            print(url!) // image url
        } else {
            // failed
         }
        }
```

- Remove images in your Firebase storage

```Swift
  KFirebase.connect().removePicture(childs: ["img","profile.jpg"])
```

- Internet connection

```Swift
  KFirebase.isConnected()
```

- You can use chain methods

```Swift
  KFirebase.connect().insert(value: "okey", childs: ["msg"]).update(values: ["name":"alice" as AnyObject], childs: ["users"]).remove(childs: ["test"])
```

