# SecurityCodeImgView

 ![image](https://github.com/dongxiexidu/SecurityCodeImgView_demo/blob/master/demo.png)


### Usage example

### support Xib or Storyboard

```
    var codeview : SecurityCodeImgView!

    override func viewDidLoad() {
        super.viewDidLoad()

        codeview = SecurityCodeImgView.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 40))
        view.addSubview(codeview)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(codeview.imageCodeStr)
    }
```
