//
//  RMSearchInputView.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 2/1/23.
//

import UIKit

protocol RMSearchInputViewDelegate: AnyObject {
    func rmSearchInputView(
        _ inputView: RMSearchInputView,
        didSelectOption option: RMSearchInputViewViewModel.DynamicOption
    )
}

class RMSearchInputView: UIView {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    weak var delegate: RMSearchInputViewDelegate?
    
    var viewModel: RMSearchInputViewViewModel? {
        didSet {
            guard let viewModel else {
                return
            }
            let options = viewModel.options
            createOptionSelectionViews(options: options)
            searchBar.placeholder = viewModel.searchPlaceholderText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @discardableResult func loadNib() -> UIView {
        let view = Bundle.main.loadNibNamed(
            "RMSearchInputView",
            owner: self,
            options: nil
        )?.first as? UIView
        
        view?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view?.frame = bounds
        addSubview(view!)
        return view!
    }
    
    private func createOptionSelectionViews(options: [RMSearchInputViewViewModel.DynamicOption]) {
        if options.count == 0 {
            return
        }
        
        let stackView = createOptionStackView()
        
        for index in 0..<options.count {
            let option = options[index]
            let button = createOptionButton(index: index, with: option)
            
            stackView.addArrangedSubview(button)
        }
    }
    
    private func createOptionButton(index: Int, with option: RMSearchInputViewViewModel.DynamicOption) -> UIButton {
        let button = UIButton()
        
        button.setAttributedTitle(
            NSAttributedString(
                string: option.rawValue,
                attributes: [
                    .font: UIFont.systemFont(ofSize: 18, weight: .medium),
                    .foregroundColor: UIColor.label
                ]
            ),
            for: .normal
        )
        button.backgroundColor = .secondarySystemFill
        button.addTarget(self, action: #selector(didTapButton(_:)),  for: .touchUpInside)
        button.tag = index
        button.layer.cornerRadius = 6
        return button
    }
    
    private func createOptionStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 5
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        return stackView
    }
    
    @objc
    private func didTapButton(_ sender: UIButton) {
        guard let option = viewModel?.options[sender.tag] else {
            return
        }
        delegate?.rmSearchInputView(self, didSelectOption: option)
    }
}
