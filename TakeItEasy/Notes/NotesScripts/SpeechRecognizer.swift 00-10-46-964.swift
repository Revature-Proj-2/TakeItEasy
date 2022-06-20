//
//  SpeechRecognizer.swift
//  TakeItEasy
//
//  Created by admin on 6/19/22.
//

import Foundation
import UIKit
import Speech

class ViewController: UIViewController {

    let audioEngine = AVAudioEngine()
    let speechRecognizer = SFSpeechRecognizer()
    let bufferRecognizerReq = SFSpeechAudioBufferRecognitionRequest()
    var recogTask : SFSpeechRecognitionTask!
    var isStart = false
    
    var startStopButton: UIButton!
    var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func startSpeechRecog(){
        let inputN = audioEngine.inputNode
        let recordF = inputN.outputFormat(forBus: 0)
        inputN.installTap(onBus: 0, bufferSize: 1024, format: recordF){ buffer, _ in
            self.bufferRecognizerReq.append(buffer)
        }
        audioEngine.prepare()
        do{
            try audioEngine.start()
        }catch{
            print("error starting audio engine")
        }
        recogTask = speechRecognizer?.recognitionTask(with: bufferRecognizerReq, resultHandler: { resp , error in
            guard let res = resp else{
                print(error)
                return
            }
            
            let msg = resp?.bestTranscription.formattedString
            self.resultLabel.text = msg
            
            var colorValue = ""
            for str in resp!.bestTranscription.segments{
                let indexTo = msg?.index(msg!.startIndex, offsetBy : str.substringRange.location)
                colorValue = String(msg![indexTo!...])
            }
            switch colorValue{
            case "blue":
                self.view.backgroundColor = .blue
            default:
                self.view.backgroundColor = .white
            }
        })
    }
    
    
    @IBAction func startRecording(_ sender: UIButton) {
        
        if isStart == false{
            
            sender.setTitle("Stop", for: .normal)
            self.resultLabel.text = "This is where I would put my speech to text ....... if I had any! \n\n\nThanks VM"
            startSpeechRecog()
        }
        if isStart == true {
            
            sender.setTitle("Start", for: .normal)
            self.resultLabel.text = "Speech to text would be stopped now."
            stopSpeechRecog()
        }
        isStart = !isStart
    }
    
    func stopSpeechRecog(){
        recogTask.finish()
        recogTask.cancel()
        recogTask = nil
        bufferRecognizerReq.endAudio()
        audioEngine.stop()
        if audioEngine.inputNode.numberOfInputs > 0 {
            audioEngine.inputNode.removeTap(onBus: 0)
        }
    }
    
}
