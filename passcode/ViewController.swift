//
//  ViewController.swift
//  passcode
//
//  Created by Alisha on 2021/1/9.
//

import UIKit

class ViewController: UIViewController {

    let correctPasscode = "1124" //旅行青蛙的首發日
    var inputPasscodeStr = ""
    let shuffledImageArray = ["frogHat","frog1","frog2","frog3","frog4"].shuffled()

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var welcomeFrog: UIImageView!
    @IBOutlet var backViewArray: [UIView]!

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var thirdImageView: UIImageView!
    @IBOutlet weak var fourthView: UIView!
    @IBOutlet weak var fourthImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        showImage()
        //尚未輸入密碼的狀態，空陣列
        print(inputPasscodeStr)
    }
    @IBAction func deleteButton(_ sender: UIButton) {
        print("Delete number")
        if 1...3 ~= inputPasscodeStr.count {
            inputPasscodeStr.removeLast()
        }
        showImage()
    }
    @IBAction func clearButton(_ sender: UIButton) {
        print("Clear all and Reload")
        inputPasscodeStr = ""
        inputCodeBefore()
    }
    @IBAction func numberButton(_ sender: UIButton) {
        inputPasscode(input: String(sender.tag))
        print(inputPasscodeStr)
    }
    func inputPasscode(input:String) {
        if 0...4 ~= inputPasscodeStr.count {
            inputPasscodeStr += input
        }
        showImage()
    }
    //初始圖片
    func welcomeImageInitial() {
        welcomeFrog.image = UIImage(named: "frog")
    }
    //初始文字
    func welcomeLabelInitial() {
        welcomeLabel.text = "輸入通關密碼我才能回家喔！"
    }
    //密碼輸入錯誤的圖片
    func welcomeImageError() {
        welcomeFrog.image = UIImage(named: "frogLeaf")
    }
    //密碼輸入錯誤的文字
    func welcomeLabelError() {
        let errorTextArray = ["你是不是討厭我...","快一點啦！我要回家！","蛙生好難..."]
        let randomErrorText = errorTextArray.randomElement()!
        welcomeLabel.text = randomErrorText
    }
    //輸入密碼出現圖片
    func showImage() {
        let passcodeCount = inputPasscodeStr.count
        welcomeLabelInitial()
        welcomeImageInitial()
        switch passcodeCount {
        case 1:
            inputOneCode()
        case 2:
            inputTwoCode()
        case 3:
            inputThreeCode()
        case 4:
            inputFourCode()
            if inputPasscodeStr == correctPasscode {
                print("CORRECT!")
                let alert = UIAlertController(title: "密碼正確", message: "恭喜！", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK!", style: .default) { (_) in
                    self.reset()
                }
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
            else {
                let alert = UIAlertController(title: "密碼錯誤", message: "請確認密碼", preferredStyle: .alert)
                let action = UIAlertAction(title: "再次輸入", style: .default) { (_) in
                    self.showImage()
                }
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
                welcomeImageError()
                welcomeLabelError()
                reset()
            }
        default:
            inputCodeBefore()
        }
    }
    //輸入密碼前
    func inputCodeBefore() {
        print("inputCodeBefore")
        firstImageView.isHidden = true
        secondImageView.isHidden = true
        thirdImageView.isHidden = true
        fourthImageView.isHidden = true
        for i in 0...3 {
            //設定底層ImageView,遮色片素材
            let backImageView = UIImageView(image: UIImage(named: "\(shuffledImageArray[i])"))
            backImageView.contentMode = .scaleAspectFit
            backImageView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
            //設定底層view
            let backView = UIView(frame: backImageView.frame)
            backView.backgroundColor = UIColor.white
            backView.frame = backImageView.frame
            backViewArray[i].mask = backImageView
            backViewArray[i].addSubview(backView)
        }
    }
    //輸入一個數字
    func inputOneCode() {
        print("inputOneCode")
        firstImageView.isHidden = false
        secondImageView.isHidden = true
        thirdImageView.isHidden = true
        fourthImageView.isHidden = true
        firstImageView.image = UIImage(named: "\(shuffledImageArray[0])")
        firstView.backgroundColor = UIColor.clear
        firstImageView.contentMode = .scaleAspectFit
        firstImageView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        for i in 1...3 {
            let backImageView = UIImageView(image: UIImage(named: "\(shuffledImageArray[i])"))
            backImageView.contentMode = .scaleAspectFit
            backImageView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
            let backView = UIView(frame: backImageView.frame)
            backView.backgroundColor = UIColor.white
            backView.frame = backImageView.frame
            backViewArray[i].mask = backImageView
            backViewArray[i].addSubview(backView)
        }
    }
    //輸入兩個數字
    func inputTwoCode() {
        print("inputTwoCode")
        firstImageView.isHidden = false
        secondImageView.isHidden = false
        thirdImageView.isHidden = true
        fourthImageView.isHidden = true
        secondImageView.image = UIImage(named: "\(shuffledImageArray[1])")
        secondView.backgroundColor = UIColor.clear
        secondImageView.contentMode = .scaleAspectFit
        secondImageView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        for i in 2...3 {
            let backImageView = UIImageView(image: UIImage(named: "\(shuffledImageArray[i])"))
            backImageView.contentMode = .scaleAspectFit
            backImageView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
            let backView = UIView(frame: backImageView.frame)
            backView.backgroundColor = UIColor.white
            backView.frame = backImageView.frame
            backViewArray[i].mask = backImageView
            backViewArray[i].addSubview(backView)
        }
    }
    //輸入三個數字
    func inputThreeCode() {
        print("inputThreeCode")
        firstImageView.isHidden = false
        secondImageView.isHidden = false
        thirdImageView.isHidden = false
        fourthImageView.isHidden = true
        thirdImageView.image = UIImage(named: "\(shuffledImageArray[2])")
        thirdView.backgroundColor = UIColor.clear
        thirdImageView.contentMode = .scaleAspectFit
        thirdImageView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        let backImageView = UIImageView(image: UIImage(named: "\(shuffledImageArray[3])"))
        backImageView.contentMode = .scaleAspectFit
        backImageView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        let backView = UIView(frame: backImageView.frame)
        backView.backgroundColor = UIColor.white
        backView.frame = backImageView.frame
        backViewArray[3].mask = backImageView
        backViewArray[3].addSubview(backView)
    }
    //輸入四個數字
    func inputFourCode() {
        print("inputFourCode")
        firstImageView.isHidden = false
        secondImageView.isHidden = false
        thirdImageView.isHidden = false
        fourthImageView.isHidden = false
        fourthImageView.image = UIImage(named: "\(shuffledImageArray[3])")
        fourthView.backgroundColor = UIColor.clear
        fourthImageView.contentMode = .scaleAspectFit
        fourthImageView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
    }
    //重新開始
    func reset() {
        inputPasscodeStr = ""
        inputCodeBefore()
    }
    
}

