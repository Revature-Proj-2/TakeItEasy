//
//  SpeechRecognizer.swift
//  TakeItEasy
//
//  Created by admin on 6/19/22.
//

import Foundation
import UIKit
import Speech

class SpeechRecognizer {

    let audioEngine = AVAudioEngine()
    let speechRecognizer = SFSpeechRecognizer()
    let bufferRecognizerReq = SFSpeechAudioBufferRecognitionRequest()
    var recogTask : SFSpeechRecognitionTask!
    var isStart = false
    
    var startStopButton: UIButton!
    var resultText: UITextView!
    
    //override func viewDidLoad() {
       // super.viewDidLoad()
        // Do any additional setup after loading the view.
   // }

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
                print(error?.localizedDescription)
                print("hiiiiiiii")
                return
            }
            print("yo yo yo it is doing it so whatsup")
            self.resultText.text = resp?.bestTranscription.formattedString
       })
    }
                                                      
    
    func startRecording(_ sender: UIButton) {
        
        if isStart == false{
            
            sender.tintColor = .blue
         
            startSpeechRecog()
        }
        if isStart == true {
            
            sender.tintColor = .gray
          
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
            audioEngine.inputNode.reset()
        }
    }
    
}
