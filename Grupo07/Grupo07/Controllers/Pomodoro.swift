//
//  Pomodoro.swift
//  Grupo07
//
//  Created by Natan Rodrigues on 19/04/22.
//

import Foundation
import UIKit
class Pomodoro{
    

//cria as constantes pro circulo
let foreProgressLayer = CAShapeLayer()
let backProgressLayer = CAShapeLayer()
let animation = CABasicAnimation(keyPath: "strokeEnd")

//cria variaveis do timer
var timer = Timer()
var isTimerStarted = false
var isAnimationStarted = false
var time = 1500
var count = 0


//funcao para calcular os segundos e minutos do timer
func formatTime()->String{
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
    return String(format:"%02i:%02i", minutes, seconds)
}
    
func resetAnimation(){
    foreProgressLayer.speed = 1.0
    foreProgressLayer.timeOffset = 0.0
    foreProgressLayer.beginTime = 0.0
    foreProgressLayer.strokeEnd = 0.0
    isAnimationStarted = false
}

func pauseAnimation(){
    let pausedTime = foreProgressLayer.convertTime(CACurrentMediaTime(), from: nil)
    foreProgressLayer.speed = 0.0
    foreProgressLayer.timeOffset = pausedTime
}

func resumeAnimation(){
    let pausedTime = foreProgressLayer.timeOffset
    foreProgressLayer.speed = 1.0
    foreProgressLayer.timeOffset = 0.0
    foreProgressLayer.beginTime = 0.0
    let timeSincePaused = foreProgressLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
    foreProgressLayer.beginTime = timeSincePaused
}

func stopAnimation(){
    foreProgressLayer.speed = 1.0
    foreProgressLayer.timeOffset = 0.0
    foreProgressLayer.beginTime = 0.0
    foreProgressLayer.strokeEnd = 0.0
    foreProgressLayer.removeAllAnimations()
    isAnimationStarted = false
}
    
}
  
extension Int{
var degreesToRadians : CGFloat{
    return CGFloat(self) * .pi / 180 //180
}
}
