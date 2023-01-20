//
//  ViewController.swift
//  LearnSwift
//
//  Created by Vincent Nguyen on 1/19/23.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, DelegateCellDelegate {
    
    func buttonTapped(sender: DelegateCell) { // Protocol + Delegate
        let indexPath = IndexPath(item: 2, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! DelegateCell // have to type cast as delegate cell to access property
        if cell.isOn {
            cell.isOn = false
            cell.backgroundColor = .red
        } else {
            cell.isOn = true
            cell.backgroundColor = .green
        }
    }
    
    let minimumSpacing: CGFloat = 10
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ButtonLabelCell.self, forCellWithReuseIdentifier: "ButtonLabelCell") // autolayout
        cv.register(SliderCell.self, forCellWithReuseIdentifier: "SliderCell") // Slider and rectangle moving
        cv.register(DelegateCell.self, forCellWithReuseIdentifier: "DelegateCell") // delegate
        cv.register(TableViewCell.self, forCellWithReuseIdentifier: "TableViewCell") // TableView Controller
        cv.register(AlignCell.self, forCellWithReuseIdentifier: "AlignCell") // AlignCell
        cv.register(Cell6.self, forCellWithReuseIdentifier: "cell6")
        cv.register(Cell7.self, forCellWithReuseIdentifier: "cell7")
        cv.register(Cell8.self, forCellWithReuseIdentifier: "cell8")
        cv.register(Cell9.self, forCellWithReuseIdentifier: "cell9")
        cv.backgroundColor = .black
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 300, height: 300)
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonLabelCell", for: indexPath) as! ButtonLabelCell
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as! SliderCell
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DelegateCell", for: indexPath) as! DelegateCell
            cell.delegate = self
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlignCell", for: indexPath) as! AlignCell
            return cell
        case 5:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell6", for: indexPath) as! Cell6
            return cell
        case 6:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell7", for: indexPath) as! Cell7
            return cell
        case 7:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell8", for: indexPath) as! Cell8
            return cell
        case 8:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell9", for: indexPath) as! Cell9
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonLabelCell", for: indexPath) as! ButtonLabelCell
            return cell
        }
    }
    
}

// MARK: - UIBUtton + Autolayout

class ButtonLabelCell: UICollectionViewCell {
    
    var isOn = false

    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "off"
        return label
    }()
    
    let button: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Button", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        btn.backgroundColor = .blue
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubview(button)
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20)
            
        ])
    }
    
    @objc func buttonPressed() {
        if isOn {
            label.text = "off"
            isOn = false
        } else {
            label.text = "on"
            isOn = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UISlider + addTarget Functions

class SliderCell: UICollectionViewCell {

    let rectangleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return view
    }()
    
    let cornerRadiusView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        view.layer.cornerRadius = 0.5 * 30
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return view
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.value = 0.5
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        return slider
    }()

    @objc func sliderValueChanged() {
        let cornerRadiusMultiplier = CGFloat(slider.value)
        cornerRadiusView.layer.cornerRadius = 30 * cornerRadiusMultiplier
        rectangleView.frame.origin.x = CGFloat(slider.value) * (frame.width - rectangleView.frame.width)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(rectangleView)
        addSubview(cornerRadiusView)
        addSubview(slider)
        NSLayoutConstraint.activate([
            // make sure when doing autolayout, add constraints to account for width and height, bottom anchor optional
            rectangleView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            rectangleView.widthAnchor.constraint(equalToConstant: 50),
            rectangleView.heightAnchor.constraint(equalToConstant: 50),
            rectangleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cornerRadiusView.topAnchor.constraint(equalTo: rectangleView.bottomAnchor, constant: 20),
            cornerRadiusView.widthAnchor.constraint(equalToConstant: 50),
            cornerRadiusView.heightAnchor.constraint(equalToConstant: 50),
            cornerRadiusView.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.widthAnchor.constraint(equalTo: widthAnchor, constant: -40),
            slider.topAnchor.constraint(equalTo: cornerRadiusView.bottomAnchor, constant: 20)
        ])
        self.backgroundColor = .white
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Protocol + Delegate

protocol DelegateCellDelegate: AnyObject {
    func buttonTapped(sender: DelegateCell)
}

class DelegateCell: UICollectionViewCell {
    weak var delegate: DelegateCellDelegate?
    var isOn = false
    let button: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Button", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        btn.backgroundColor = .white
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        delegate?.buttonTapped(sender: self)
    }
}

// MARK: - TableView + Delegate

class TableViewCell: UICollectionViewCell {
    let tableView = UITableView()
       var data: [String] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        populateData()
        addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func populateData() {
        for i in 0..<10 {
            data.append(String(i))
        }
    }
    override func layoutSubviews() {
            super.layoutSubviews()
            tableView.frame = bounds
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .blue
        return cell
    }
}

extension TableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected: \(data[indexPath.row])")
    }
}
// MARK: - Aligning Frames vs. Bounds

class AlignCell: UICollectionViewCell {
    
    let centerRectView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return view
    }()
    
    let alignRectView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        view.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        return view
    }()
    
    let centerButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Center", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(alignCenter), for: .touchUpInside)
        btn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        btn.backgroundColor = .blue
        return btn
    }()
    
    let alignLeftButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Align Left", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(alignLeft), for: .touchUpInside)
        btn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        btn.backgroundColor = .blue
        return btn
    }()
    
    let alignRightButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Align Right", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(alignRight), for: .touchUpInside)
        btn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        btn.backgroundColor = .blue
        return btn
    }()
    
    let alignTopButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Align Top", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(alignTop), for: .touchUpInside)
        btn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        btn.backgroundColor = .blue
        return btn
    }()
    
    let alignBottomButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Align Bottom", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(alignBottom), for: .touchUpInside)
        btn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        btn.backgroundColor = .blue
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubview(centerRectView)
        addSubview(alignRectView)
        addSubview(centerButton)
        addSubview(alignLeftButton)
        addSubview(alignRightButton)
        addSubview(alignTopButton)
        addSubview(alignBottomButton)
        NSLayoutConstraint.activate([
            centerRectView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -70),
            centerRectView.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerRectView.widthAnchor.constraint(equalToConstant: 100),
            centerRectView.heightAnchor.constraint(equalToConstant: 100),
            alignRectView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -70),
            alignRectView.centerXAnchor.constraint(equalTo: centerXAnchor),
            alignRectView.widthAnchor.constraint(equalToConstant: 20),
            alignRectView.heightAnchor.constraint(equalToConstant: 20),
            centerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerButton.topAnchor.constraint(equalTo: centerRectView.bottomAnchor, constant: 70),
            alignLeftButton.trailingAnchor.constraint(equalTo: centerButton.leadingAnchor, constant: -10),
            alignLeftButton.topAnchor.constraint(equalTo: centerButton.topAnchor),
            alignRightButton.leadingAnchor.constraint(equalTo: centerButton.trailingAnchor, constant: 10),
            alignRightButton.topAnchor.constraint(equalTo: centerButton.topAnchor),
            alignTopButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            alignTopButton.bottomAnchor.constraint(equalTo: centerButton.topAnchor, constant: -10),
            alignBottomButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            alignBottomButton.topAnchor.constraint(equalTo: centerButton.bottomAnchor, constant: 10),
        ])
    }
    
    @objc func alignCenter() {
        alignRectView.frame.origin.x = centerRectView.frame.origin.x + (centerRectView.frame.width - alignRectView.frame.width) / 2
        alignRectView.frame.origin.y = centerRectView.frame.origin.y + (centerRectView.frame.height - alignRectView.frame.height) / 2
    }
    
    @objc func alignLeft() {
        alignRectView.frame.origin.x = centerRectView.frame.origin.x
    }
    
    @objc func alignRight() {
        alignRectView.frame.origin.x = centerRectView.frame.origin.x + (centerRectView.frame.width - alignRectView.frame.width)
    }
    
    @objc func alignTop() {
        alignRectView.frame.origin.y = centerRectView.frame.origin.y
    }
    
    @objc func alignBottom() {
        alignRectView.frame.origin.y = centerRectView.frame.origin.y + (centerRectView.frame.height - alignRectView.frame.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Cell6: UICollectionViewCell {
    let apiUrl = "https://example.com/api"

       func makeAPICall() {
           guard let url = URL(string: apiUrl) else {
               print("Error: Invalid URL")
               return
           }

           let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
               guard let data = data, error == nil else {
                   print("Error: \(error?.localizedDescription ?? "Unknown Error")")
                   return
               }

               // Parse the JSON data
               let json = try? JSONSerialization.jsonObject(with: data, options: [])
               if let json = json {
                   print(json)
               }
           }

           task.resume()
       }
    override init(frame: CGRect) {
        super.init(frame: frame)
       // makeAPICall()
        self.backgroundColor = .white

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




class Cell7: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Cell8: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class Cell9: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
