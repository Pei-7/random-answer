//
//  ViewController.swift
//  random answer
//
//  Created by 陳佩琪 on 2023/5/4.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    


//home page
    @IBOutlet weak var homePageView: UIView!
    @IBOutlet weak var trueOrFalseQButton: UIButton!
    @IBOutlet weak var multipleChoiceQButton: UIButton!
    @IBOutlet weak var shortAnswerQButton: UIButton!
    @IBOutlet weak var luckCheckQButton: UIButton!
    
//true Or False
    @IBOutlet var trueOrFalseView: UIView!
    @IBOutlet weak var tfResultLabel: UILabel!
    @IBOutlet weak var tfNextButton: UIButton!
    
//multiple Choice
    @IBOutlet var multipleChoiceView: UIView!
    @IBOutlet weak var mcNumberOfChoiceLabel: UILabel!
    @IBOutlet weak var mcStepper: UIStepper!
    @IBOutlet weak var mcResultLabel: UILabel!
    @IBOutlet weak var mcNextButton: UIButton!
    
//short Answer
    @IBOutlet var shortAnswerView: UIView!
    @IBOutlet weak var fullPrayImageView: UIImageView!
    @IBOutlet weak var leftPrayImageView: UIImageView!
    @IBOutlet weak var rightPrayImageView: UIImageView!
    @IBOutlet weak var saResultLabel: UILabel!
    @IBOutlet weak var saExplanationLabel: UILabel!
    @IBOutlet weak var saNextButton: UIButton!
    
//luck Check
    @IBOutlet var luckCheckView: UIView!
    
    @IBOutlet weak var lcNumberOfChoiceLabel: UILabel!
    @IBOutlet weak var lcStepper: UIStepper!
    @IBOutlet weak var lcResultLabel: UILabel!
    @IBOutlet weak var lcExplanationLabel: UILabel!
    @IBOutlet weak var resultToGuessLabel: UILabel!
    @IBOutlet weak var guessBigOrSmall: UISegmentedControl!

    @IBOutlet weak var lcNextButton: UIButton!
    @IBOutlet var diceImageViews: [UIImageView]!
    @IBOutlet var diceViews: [UIView]!
    
    var writePlayer: AVAudioPlayer?
    var prayPlayer: AVAudioPlayer?
    var dicePlayer: AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//home page
        homePageView.addSubview(trueOrFalseView)
        homePageView.addSubview(multipleChoiceView)
        homePageView.addSubview(shortAnswerView)
        homePageView.addSubview(luckCheckView)

        trueOrFalseView.isHidden = true
        multipleChoiceView.isHidden = true
        shortAnswerView.isHidden = true
        luckCheckView.isHidden = true

//tf
        nextButtonText(button: tfNextButton, label: tfResultLabel)
        
        
//mc
        mcStepper.minimumValue = 3
        mcStepper.maximumValue = 10
        mcStepper.stepValue = 1
        mcStepper.value = 4
        mcNumberOfChoiceLabel.text = "\(Int(mcStepper.value))"
        nextButtonText(button: mcNextButton, label: mcResultLabel)
     
//sa
        leftPrayImageView.isHidden = true
        rightPrayImageView.isHidden = true
        fullPrayImageView.isHidden = false
        saResultLabel.text = nil
        saExplanationLabel.text = nil
        nextButtonText(button: saNextButton, label: saResultLabel)
        
        
//lc
        
        lcStepper.minimumValue = 1
        lcStepper.maximumValue = 6
        lcStepper.stepValue = 1
        lcStepper.value = 3
        lcNumberOfChoiceLabel.text = "\(Int(lcStepper.value))"
        lcResultLabel.text = nil
        resultToGuessLabel.text = nil
        lcExplanationLabel.text = nil
        nextButtonText(button: lcNextButton, label: lcResultLabel)
        
        for dice in diceImageViews {
            dice.image = UIImage(named: "6")
        }
    
        for diceview in diceViews {
            luckCheckView.addSubview(diceview)
            diceview.frame = CGRect(x: 75, y: 258, width: 240, height: 240)
            diceview.backgroundColor = UIColor.clear
            diceview.isHidden = true
        }
        diceViews[Int(lcStepper.value)-1].isHidden = false
        
        
//sound effects
        
        let praySound = Bundle.main.url(forResource: "praySound", withExtension: "mp3")!
        do {
            prayPlayer = try AVAudioPlayer(contentsOf: praySound)
                } catch {
                    print("播放音效檔案出現錯誤：\(error)")
                }
              

        let rollDiceSound = Bundle.main.url(forResource: "rollDiceSound", withExtension: "mp3")!
        do {
            dicePlayer = try AVAudioPlayer(contentsOf: rollDiceSound)
                } catch {
                    print("播放音效檔案出現錯誤：\(error)")
                }
              
        let writeSound = Bundle.main.url(forResource: "writeSound", withExtension: "mp3")!
        do {
            writePlayer = try AVAudioPlayer(contentsOf: writeSound)
            writePlayer?.volume = 0.6
                } catch {
                    print("播放音效檔案出現錯誤：\(error)")
                }
        
    }

//my functions
    
    //home page 切換頁面
    func selectQuestionType(questionType: UIView) {
        trueOrFalseView.isHidden = true
        multipleChoiceView.isHidden = true
        shortAnswerView.isHidden = true
        luckCheckView.isHidden = true
        questionType.isHidden = false
    }
    
    //next label text
    func nextButtonText(button: UIButton, label: UILabel) {
        if label.text != nil {
            if luckCheckView.isHidden == false {
                button.setTitle("再擲一次", for: .normal)
            } else {
                button.setTitle("下一題", for: .normal)
            }
        }else {
            if luckCheckView.isHidden == false {
                button.setTitle("擲骰子", for: .normal)
            } else {
                button.setTitle("求解", for: .normal)
            }
        }
    }
    
    //player start all time
    func playSoundEffect(player: AVAudioPlayer?) {
        player!.play()
        player!.stop()
        player!.currentTime = 0
        player!.play()
    }
    
    
    
    
//home page
    @IBAction func selectTrueOfFalse(_ sender: Any) {
        selectQuestionType(questionType: trueOrFalseView)
        tfResultLabel.text = nil
        nextButtonText(button: tfNextButton, label: tfResultLabel)
    }
    
    @IBAction func selectMultipleQuestion(_ sender: Any) {
        selectQuestionType(questionType: multipleChoiceView)
        mcResultLabel.text = nil
        nextButtonText(button: mcNextButton, label: mcResultLabel)
    }
    
    
    @IBAction func selectShortAnswer(_ sender: Any) {
        selectQuestionType(questionType: shortAnswerView)
        leftPrayImageView.isHidden = true
        rightPrayImageView.isHidden = true
        fullPrayImageView.isHidden = false
        saResultLabel.text = nil
        saExplanationLabel.text = nil
        nextButtonText(button: saNextButton, label: saResultLabel)
    }
    
    @IBAction func selectLuckCheck(_ sender: Any) {
        selectQuestionType(questionType: luckCheckView)
        lcResultLabel.text = nil
        resultToGuessLabel.text = nil
        lcExplanationLabel.text = nil
        nextButtonText(button: lcNextButton, label: lcResultLabel)
        
        lcStepper.value = 3
        lcNumberOfChoiceLabel.text = "\(Int(lcStepper.value))"
        for dice in diceImageViews {
            dice.image = UIImage(named: "6")
        }
    }
    
    @IBAction func returnToHomePage(_ sender: Any) {
        selectQuestionType(questionType: homePageView)
        
       
    }
    
    

    
    
//tf
    @IBAction func tfRandomAction(_ sender: Any) {
        playSoundEffect(player: writePlayer)
        let randomIndex = Bool.random()
        if randomIndex == true {
            tfResultLabel.text = "Ｏ"
        } else {
            tfResultLabel.text = "X"
        }
        nextButtonText(button: tfNextButton, label: tfResultLabel)
    }
    
//mc
    @IBAction func mcNumberOfChoicesAction(_ sender: Any) {
        mcNumberOfChoiceLabel.text = "\(Int(mcStepper.value))"
    }
    
    @IBAction func mcRandomAction(_ sender: Any) {
        playSoundEffect(player: writePlayer)
        let randomIndex = Int.random(in: 0...Int(mcStepper.value)-1)
        let mcChoicesText = ["A","B","C","D","E","F","G","H","I","J"]
        mcResultLabel.text = mcChoicesText[randomIndex]
        nextButtonText(button: mcNextButton, label: mcResultLabel)
    }
        
//sa
    @IBAction func saRandomAction(_ sender: Any) {
        playSoundEffect(player: prayPlayer)
        let leftImageName = ["leftPray+","leftPray-"]
        let leftIndex = Int.random(in: 0...1)
        let rightImageName = ["rightPray+","rightPray-"]
        let rightIndex = Int.random(in: 0...1)
        let resultText = ["笑筊","聖筊","陰筊"]
        let explanationText = ["你再仔細想一想。","你所想的是正確的。","方向完全錯了。"]
        
        fullPrayImageView.isHidden = true
        leftPrayImageView.isHidden = false
        rightPrayImageView.isHidden = false
        
        leftPrayImageView.image = UIImage(named: leftImageName[leftIndex])
        rightPrayImageView.image = UIImage(named: rightImageName[rightIndex])
        
        saResultLabel.text = resultText[leftIndex + rightIndex]
        saExplanationLabel.text = explanationText[leftIndex + rightIndex]
        
        nextButtonText(button: saNextButton, label: saResultLabel)
        
    }
    
    
//lc
    @IBAction func lcNumberOfDicesAction(_ sender: Any) {
        lcNumberOfChoiceLabel.text = "\(Int(lcStepper.value))"
        let index = ( Int(lcStepper.value)-1 ) % 6
        for diceView in diceViews {
            diceView.isHidden = true
        }
        diceViews[index].isHidden = false
    }
    
    
    @IBAction func lcRandomAction(_ sender: Any) {
        playSoundEffect(player: dicePlayer)
        var diceResult = 0
        for diceView in diceViews {
                    if !diceView.isHidden {
                        // 這一句是 ChatGPT 幫我修改的，為了運行 diceResult 計算時不會計算到其他 view 上的骰子
                        for dice in diceView.subviews where dice is UIImageView {
                            let number = Int.random(in: 1...6)
                            (dice as! UIImageView).image = UIImage(named: String(number))
                            diceResult += number
                        }
                    }
                }
        let diceTotal = lcStepper.value * 6
        lcResultLabel.text = "\(diceResult)"
        let resultToGuessText = ["壓對了。","壓錯了。"]
        let explanationText = ["你可以放心使用本 App。","或許本 App 不太適合你。"]
        
        
        if guessBigOrSmall.selectedSegmentIndex == 0 {
            if CGFloat(diceResult) > CGFloat(diceTotal / 2) { //錯誤提示：Operator function '>' requires that 'CGFloat' conform to 'BinaryInteger'
                resultToGuessLabel.text = resultToGuessText[0]
                lcExplanationLabel.text = explanationText[0]
            } else {
                resultToGuessLabel.text = resultToGuessText[1]
                lcExplanationLabel.text = explanationText[1]
            }
        } else if guessBigOrSmall.selectedSegmentIndex == 1 {
            if CGFloat(diceResult) > CGFloat(diceTotal / 2) {
                resultToGuessLabel.text = resultToGuessText[1]
                lcExplanationLabel.text = explanationText[1]
            } else {
                resultToGuessLabel.text = resultToGuessText[0]
                lcExplanationLabel.text = explanationText[0]
            }
            
        }
        nextButtonText(button: lcNextButton, label: lcResultLabel)
            
        
    }
    
  
    
    
    
    
    
    
    
    
    
    
    
    
    
// motion
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
       if motion == .motionShake {
           if trueOrFalseView.isHidden == false {
               let randomIndex = Bool.random()
               if randomIndex == true {
                   tfResultLabel.text = "Ｏ"
               } else {
                   tfResultLabel.text = "X"
               }
               nextButtonText(button: tfNextButton, label: tfResultLabel)
           } else if multipleChoiceView.isHidden == false {
               let randomIndex = Int.random(in: 0...Int(mcStepper.value)-1)
               let mcChoicesText = ["A","B","C","D","E","F","G","H","I","J"]
               mcResultLabel.text = mcChoicesText[randomIndex]
               nextButtonText(button: mcNextButton, label: mcResultLabel)
           } else if shortAnswerView.isHidden == false {
               prayPlayer?.play()
               let leftImageName = ["leftPray+","leftPray-"]
               let leftIndex = Int.random(in: 0...1)
               let rightImageName = ["rightPray+","rightPray-"]
               let rightIndex = Int.random(in: 0...1)
               let resultText = ["笑筊","聖筊","陰筊"]
               let explanationText = ["你再仔細想一想。","你所想的是正確的。","方向完全錯了。"]
               
               fullPrayImageView.isHidden = true
               leftPrayImageView.isHidden = false
               rightPrayImageView.isHidden = false
               
               leftPrayImageView.image = UIImage(named: leftImageName[leftIndex])
               rightPrayImageView.image = UIImage(named: rightImageName[rightIndex])
               
               saResultLabel.text = resultText[leftIndex + rightIndex]
               saExplanationLabel.text = explanationText[leftIndex + rightIndex]
               
               nextButtonText(button: saNextButton, label: saResultLabel)
               
           } else if luckCheckView.isHidden == false {
               dicePlayer?.play()
               var diceResult = 0
               for diceView in diceViews {
                   if !diceView.isHidden {
                       for dice in diceView.subviews where dice is UIImageView { //我們在遍歷 diceView 的子視圖時，使用了 where 子句來過濾出只有 UIImageView 的子視圖，以避免遍歷其它類型的子視圖。
                           let number = Int.random(in: 1...6)
                           (dice as! UIImageView).image = UIImage(named: String(number))
                           diceResult += number
                       }
                   }
               }
                     
               let diceTotal = lcStepper.value * 6
               lcResultLabel.text = "\(diceResult)"
               let resultToGuessText = ["壓對了。","壓錯了。"]
               let explanationText = ["你可以放心使用本 App。","或許本 App 不太適合你。"]
               
               
               if guessBigOrSmall.selectedSegmentIndex == 0 {
                   if CGFloat(diceResult) > CGFloat(diceTotal / 2) { //錯誤提示：Operator function '>' requires that 'CGFloat' conform to 'BinaryInteger'
                       resultToGuessLabel.text = resultToGuessText[0]
                       lcExplanationLabel.text = explanationText[0]
                   } else {
                       resultToGuessLabel.text = resultToGuessText[1]
                       lcExplanationLabel.text = explanationText[1]
                   }
               } else if guessBigOrSmall.selectedSegmentIndex == 1 {
                   if CGFloat(diceResult) > CGFloat(diceTotal / 2) {
                       resultToGuessLabel.text = resultToGuessText[1]
                       lcExplanationLabel.text = explanationText[1]
                   } else {
                       resultToGuessLabel.text = resultToGuessText[0]
                       lcExplanationLabel.text = explanationText[0]
                   }
                   
               }
               nextButtonText(button: lcNextButton, label: lcResultLabel)
                   
               
           }
       }
    }
    
    
}

