# GitBlamePR
Mac app that shows pull request last modified each line of a file.

![Dec-20-2019 23-50-30](https://user-images.githubusercontent.com/1035994/71262771-d46fb500-2383-11ea-9646-f0b991248c44.gif)

## Installing
Download the latest [release](https://github.com/maoyama/GitBlamePR/releases), unzip, and run GitBlamePR.app.

## Xcode Source Editor Extension
GitBlamePR.app bundles Xcode Source Editor Extension.  

Files opened in Xcode can be easily opened in GitBlamePR.app.  
I recommend that you set a key binding for this function.

![Xcode Source Editor Extension](https://user-images.githubusercontent.com/1035994/77128451-860da780-6a93-11ea-8257-c1929f802302.gif)

## URL Scheme
GitBlamePR.app defines a URL scheme that can open the specified file.  
```
gitblamepr://{fileFullPath}
```

So you can easily open the specified file using command line, e.g:  
```bash
$ open gitblamepr://$(realpath example.txt | nkf -WwMQ | tr = %)
```


## Requirements
macOS Catalina
