//
//  TSChatViewController+ActionBar.swift
//  TSWeChat
//
//  Created by Hilen on 1/4/16.
//  Copyright © 2016 Hilen. All rights reserved.
//

import Foundation
import Closures


// MARK: - @extension TSChatViewController
extension TSChatViewController {
    /**
     初始化操作栏的 button 事件。包括 声音按钮，录音按钮，表情按钮，分享按钮 等各种事件的交互
     */
    func setupActionBarButtonInterAction() {
        let voiceButton: TSChatButton = self.chatActionBarView.voiceButton
        let recordButton: UIButton = self.chatActionBarView.recordButton
        let emotionButton: TSChatButton = self.chatActionBarView.emotionButton
        let shareButton: TSChatButton = self.chatActionBarView.shareButton
        
        //切换声音按钮
        voiceButton.onTap {
            self.chatActionBarView.resetButtonUI()
            //根据不同的状态进行不同的键盘交互
            let showRecoring = self.chatActionBarView.recordButton.isHidden
            if showRecoring {
                self.chatActionBarView.showRecording()
                voiceButton.emotionSwiftVoiceButtonUI(showKeyboard: true)
                self.controlExpandableInputView(showExpandable: false)
            } else {
                self.chatActionBarView.showTyingKeyboard()
                voiceButton.emotionSwiftVoiceButtonUI(showKeyboard: false)
                self.controlExpandableInputView(showExpandable: true)
            }
        }
        
        
        //录音按钮
        var finishRecording: Bool = true  //控制滑动取消后的结果，决定停止录音还是取消录音
        recordButton.addLongPressGesture() { longTap in

//            if longTap.state == .began { //长按开始
//                finishRecording = true
//                strongSelf.voiceIndicatorView.recording()
//                AudioRecordInstance.startRecord()
//                recordButton.replaceRecordButtonUI(isRecording: true)
//            } else if longTap.state == .changed { //长按平移
//                let point = longTap.location(in: self!.voiceIndicatorView)
//                if strongSelf.voiceIndicatorView.point(inside: point, with: nil) {
//                    strongSelf.voiceIndicatorView.slideToCancelRecord()
//                    finishRecording = false
//                } else {
//                    strongSelf.voiceIndicatorView.recording()
//                    finishRecording = true
//                }
//            } else if longTap.state == .ended { //长按结束
//                if finishRecording {
//                    AudioRecordInstance.stopRecord()
//                } else {
//                    AudioRecordInstance.cancelRrcord()
//                }
//                strongSelf.voiceIndicatorView.endRecord()
//                recordButton.replaceRecordButtonUI(isRecording: false)
//            }
        }
        
        
        //表情按钮
        emotionButton.onTap {
            self.chatActionBarView.resetButtonUI()
            //设置 button 的UI
            emotionButton.replaceEmotionButtonUI(showKeyboard: !emotionButton.showTypingKeyboard)
            //根据不同的状态进行不同的键盘交互
            if emotionButton.showTypingKeyboard {
                self.chatActionBarView.showTyingKeyboard()
            } else {
                self.chatActionBarView.showEmotionKeyboard()
            }
            
            self.controlExpandableInputView(showExpandable: true)
        }
        
        
        //分享按钮
        shareButton.onTap {

            self.chatActionBarView.resetButtonUI()
            //根据不同的状态进行不同的键盘交互
            if shareButton.showTypingKeyboard {
                self.chatActionBarView.showTyingKeyboard()
            } else {
                self.chatActionBarView.showShareKeyboard()
            }
            self.controlExpandableInputView(showExpandable: true)
        }

        
        //文字框的点击，唤醒键盘
        let textView: UITextView = self.chatActionBarView.inputTextView

        textView.addTapGesture() {_ in 
            textView.inputView = nil
            textView.becomeFirstResponder()
            textView.reloadInputViews()
        }
    }
    
    /**
    Control the actionBarView height:
    We should make actionBarView's height to original value when the user wants to show recording keyboard.
    Otherwise we should make actionBarView's height to currentHeight
    
    - parameter showExpandable: show or hide expandable inputTextView
    */
    func controlExpandableInputView(showExpandable: Bool) {
        let textView = self.chatActionBarView.inputTextView
        let currentTextHeight = self.chatActionBarView.inputTextViewCurrentHeight
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            let textHeight = showExpandable ? currentTextHeight : kChatActionBarOriginalHeight
            self.chatActionBarView.snp.updateConstraints { (make) -> Void in
                make.height.equalTo(textHeight)
            }
            self.view.layoutIfNeeded()
            self.listTableView.scrollBottomToLastRow()
            textView?.contentOffset = CGPoint.zero
        }) 
    }
}








