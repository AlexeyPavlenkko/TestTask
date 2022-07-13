//
//  HomeCollectionViewController.swift
//  TestTask
//
//  Created by Алексей Павленко on 06.07.2022.
//

import UIKit

private let reuseIdentifier = "CategoryCell"

class CategoryCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.collectionViewLayout = createLayout()
    }
    
    // MARK: - UICollectionViewCompositionalLayout
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        return UICollectionViewCompositionalLayout(section: section)
        
    }
    
    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return CategoryViewModel.allCases.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
    
        let categoryModel = CategoryViewModel.allCases[indexPath.item]
        
        cell.configure(with: categoryModel)
        cell.imageView.layer.cornerRadius = 20
        cell.layer.cornerRadius = 20
        
        return cell
    }
    
    // MARK: - Segue
    
    @IBSegueAction func showDayListTableVC(_ coder: NSCoder, sender: Any?) -> DayListTableViewController? {
        guard let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPath(for: cell) else { return nil }
        
        let category = CategoryViewModel.allCases[indexPath.item]
        
        return DayListTableViewController(coder: coder, category: category)
        
    }
    
    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue) {
        
    }
    
}
