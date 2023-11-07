//
//  ItemTableViewCell.swift
//  Todoey-CordeData
//
//  Created by Long Bảo on 13/03/2023.
//

import UIKit

protocol ItemTableViewCellDelegate: AnyObject {
    func didTapDeleteButton(_: IndexPath?)
}

class ItemTableViewCell: UITableViewCell {
    //MARK: - Properties
    weak var delegate: ItemTableViewCellDelegate?
    static let reuseIdentifier = "ItemTableViewCell"
    var indexPath: IndexPath?
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Delete", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.tintColor = .red
        button.addTarget(self, action: #selector(handleDeleteButtonTapped), for: .touchUpInside)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        
        return button
    }()
    
    //MARK: - View LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(deleteButton)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: deleteButton.leftAnchor, constant: -25).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
        
        deleteButton.topAnchor.constraint(equalTo: topAnchor, constant: 6).isActive = true
        deleteButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -6).isActive = true
        deleteButton.setContentHuggingPriority(.required, for: .horizontal)
        deleteButton.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    //MARK: - Selectors
    @objc func handleDeleteButtonTapped() {
        delegate?.didTapDeleteButton(self.indexPath)
    }
}

