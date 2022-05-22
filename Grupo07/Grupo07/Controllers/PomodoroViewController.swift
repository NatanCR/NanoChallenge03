//
//  ViewController.swift
//  Grupo07
//
//  Created by Natan Rodrigues on 08/04/22.
//

import UIKit

class PomodoroViewController: UIViewController, CAAnimationDelegate {
    
    let pomodoro = Pomodoro()
    var delegate: ListaPomodorosConcluidosProtocol?
    var materia: Materia?

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawBackLayer()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(addTapped))

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //AO VOLTAR PARA A PAGINA DE HISTORICO - PASSO 1.3
        if pomodoro.count > 0 {
            //PASSO 2.3
            guard let delegate = delegate else {
                return
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            //gera a lista de pomodoros
            //PASSO 6.3
            //coloca os dados nesse formato para exibir
            delegate.inserir_pomodoro_concluido(data: "\(dateFormatter.string(from: Date()))", pomodoros: pomodoro.count)
     
        }
        
    }
    
    
    @IBAction func startButtonTapped(_ sender: Any) {
        cancelButton.isEnabled = true
        cancelButton.alpha = 1.0
        cancelButton.setTitleColor(UIColor.init(red: 0.996, green: 0.353, blue: 0.623, alpha: 1), for: .normal) //cor do botao cancelar
       
        
        if !pomodoro.isTimerStarted{ //logica para mostrar o botao de pause apos iniciar o timer
            drawForeLayer()
            startResumeAnimation()
            startTimer()
            pomodoro.isTimerStarted = true
            startButton.setTitle("Pause", for: .normal)
            startButton.setTitleColor(UIColor.orange, for: .normal)
        }else {
            pomodoro.pauseAnimation()
            pomodoro.timer.invalidate() //logica para mostrar o botao resume caso pause o timer
            pomodoro.isTimerStarted = false
            startButton.setTitle("Resume", for: .normal)
            startButton.setTitleColor(UIColor.init(red: 0.438, green: 0.863, blue: 0.659, alpha: 1), for: .normal)
        }
    }

    //botao de cancelar
    @IBAction func cancelButtonTapped(_ sender: Any) {
        pomodoro.stopAnimation()
        cancelButton.isEnabled = false //logica para mostrar o botao de start apos cancelar o timer
        cancelButton.alpha = 0.5
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(UIColor.init(red: 0.438, green: 0.863, blue: 0.659, alpha: 1), for: .normal)
        
        //faz o timer voltar ao inicio e contar 25 min novamente
        pomodoro.timer.invalidate()
        pomodoro.time = 1500
        pomodoro.isTimerStarted = false
        timeLabel.text = "25:00"
    
}
    
    @objc func updateTimer(){
        //AO INICIAR O TIMER (PASSA A CADA SEGUNDO) - PASSO 6.2
        if pomodoro.time<1{
            pomodoro.count = pomodoro.count + 1
            //AO TERMINAR O POMODORO - PASSO 7.2
            label.text = "\(pomodoro.count)"
            cancelButton.isEnabled = false
            cancelButton.alpha = 0.8
            startButton.setTitle("Start", for: .normal)
            startButton.setTitleColor(UIColor.init(red: 0.438, green: 0.863, blue: 0.659, alpha: 1), for: .normal)
            pomodoro.timer.invalidate()
            pomodoro.time = 1500
            pomodoro.isTimerStarted = false
            timeLabel.text = "25:00"
        }else{
            pomodoro.time -= 1
            timeLabel.text = pomodoro.formatTime()
        }
    }
    
    func startTimer(){
        pomodoro.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    //logica para continuar de onde foi pausado
    func startResumeAnimation(){
        if !pomodoro.isAnimationStarted{
            startAnimation()
        }else{
            pomodoro.resumeAnimation()
        }
    }

    //quando a animação estiver concluída, a barra de progresso circular vermelha deve ser redefinida
    //funcao para fazer a animacao rodar
    func startAnimation(){
        pomodoro.resetAnimation()
        pomodoro.foreProgressLayer.strokeEnd = 0.0
        pomodoro.animation.keyPath = "strokeEnd"
        pomodoro.animation.fromValue = 0
        pomodoro.animation.toValue = 1
        pomodoro.animation.duration = 1500
        pomodoro.animation.delegate = self
        pomodoro.animation.isRemovedOnCompletion = false
        pomodoro.animation.isAdditive = true
        pomodoro.animation.fillMode = CAMediaTimingFillMode.forwards
        pomodoro.foreProgressLayer.add(pomodoro.animation, forKey: "strokeEnd")
        pomodoro.isAnimationStarted = true
    }
    
    internal func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        pomodoro.stopAnimation()
    }
    
    //cria o circulo e personaliza //background layer
    func drawBackLayer(){
        pomodoro.backProgressLayer.path = UIBezierPath(arcCenter: CGPoint(x:view.frame.midX, y:view.frame.midY), radius: 120, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        pomodoro.backProgressLayer.strokeColor = UIColor.white.cgColor
        pomodoro.backProgressLayer.fillColor = UIColor.clear.cgColor
        pomodoro.backProgressLayer.lineWidth = 15
            view.layer.addSublayer(pomodoro.backProgressLayer)
    }
    
    //funcao cria o circulo que sobrepoe o primeiro
    //fore layer which is the animated red one
    func drawForeLayer(){
        pomodoro.foreProgressLayer.path = UIBezierPath(arcCenter: CGPoint(x:view.frame.midX, y:view.frame.midY), radius: 120, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        pomodoro.foreProgressLayer.strokeColor = CGColor(red: 0.796, green: 0.294, blue: 0.459, alpha: 1)
        pomodoro.foreProgressLayer.fillColor = UIColor.clear.cgColor
        pomodoro.foreProgressLayer.lineWidth = 15
            view.layer.addSublayer(pomodoro.foreProgressLayer)
        
    }
    
    @objc func addTapped(){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PomodoroTableViewController") as? PomodoroTableViewController {
            self.navigationController?.popViewController(animated: true)
    }
    
    }
    
    }
