//
//  ViewController.swift
//  collectionViewcell
//
//  Created by Ayush Sharma on 27/07/22.
//

import UIKit
class ViewController: UIViewController {
    let headerId = "headerId"
    let categoryHeaderId = "categoryHeaderView"
    let sections = ["Message for Nainika","Notice Board"]
    @IBOutlet weak var attendenceView: UIView!
    @IBOutlet weak var myView: UIView!
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.layer.cornerRadius = imageView.frame.size.height/2
        myCollectionView.register(CategoryHeaderView.self, forSupplementaryViewOfKind: categoryHeaderId, withReuseIdentifier: headerId)
        
//        myCollectionView.registerHeader.self, bundle: nil), forSupplementaryViewOfKind: headerId, withReuseIdentifier: categoryHeaderId)
        
        myCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        myCollectionView.register(UINib(nibName: "SecondCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Dell")
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        myCollectionView.collectionViewLayout = createCompositionalLayout()
        myCollectionView.reloadData()
        
        attendenceView.layer.cornerRadius = 10
      
        
        myView.layer.cornerRadius = 10
        
        
        
    }
    
   
    

    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            switch sectionNumber {
            case 0: return self.firstLayoutSection()
   
                
            default: return  self.secondLayoutSection()
            }
            
        }
    }
    
    
    
    
    private func firstLayoutSection() -> NSCollectionLayoutSection {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 15, trailing: 15)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1
        )
        //        group.contentInsets.trailing = 15
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 10
        
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: 0,
                                      leading: 10,
                                      bottom: 15,
                                      trailing: 0)
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44)), elementKind: categoryHeaderId, alignment: .top)
        ]
        section.interGroupSpacing = 5
        return section
    }
    
    
//    private func supplymentoryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
//        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated (50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
//    }
    
    private func secondLayoutSection() -> NSCollectionLayoutSection {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 15, trailing: 0)
         
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(500))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])//(layoutSize: groupSize, subitem: [item] //, count: 1
           group.contentInsets.trailing = 15
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 10
        
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0,
                                      leading: 10,
                                      bottom: 15,
                                      trailing: 0)
        section.interGroupSpacing = 5

        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44)), elementKind: categoryHeaderId, alignment: .top)
        ]
        
        return section

    }
    
}
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    //MARK: header space manage that thing

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      
        if indexPath.section == 0 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! CategoryHeaderView
        header.label.text = "Notice Board"
        return header
        } else if indexPath.section == 1  {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! CategoryHeaderView
        header.label.text = "Message for Nainika"
         return header
        }
       return UICollectionReusableView()
        
        }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
            
            return  cell
        }
        else if indexPath.section == 1{
            let dell = collectionView.dequeueReusableCell(withReuseIdentifier: "Dell", for: indexPath) as! SecondCollectionViewCell
            return dell
        }else{
            return UICollectionViewCell()
        }
        
    }
    
}

class CategoryHeaderView: UICollectionReusableView {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        label.text = "Message for Nainika"
      //  label.text = "Notice Board"
        print(label)
        addSubview(label)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//

