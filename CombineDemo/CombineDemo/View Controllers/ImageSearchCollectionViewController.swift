//
//  ImageSearchCollectionViewController.swift
//
//  Created by Daniel No on 5/18/21.
//

import UIKit
import CoreData

class ImageSearchCollectionViewController: UICollectionViewController {
//    var fetchedResultsController: NSFetchedResultsController<Pokemon>!
    lazy var searchController : UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for pokemon"
        return searchController
    }()
    
    enum Section : Int {
        case main
    }
    
    let reuseID = "reuseID"
    
//    var originalItems : [NSManagedObjectID] {
//        get{
//            return self.fetchedResultsController.fetchedObjects?.compactMap {
//                return $0.objectID
//            } ?? []
//
//        }
//    }
    
    lazy var dataSource : UICollectionViewDiffableDataSource<Section,NSManagedObjectID> = {
        let datasource : UICollectionViewDiffableDataSource<Section,NSManagedObjectID> = UICollectionViewDiffableDataSource(collectionView: self.collectionView) { (colView, indexPath, objectID) -> UICollectionViewCell? in
                let cell = colView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseID, for: indexPath) as! ImageCollectionViewCell
//                let obj = self.dataContainer?.viewContext.object(with: objectID) as! Pokemon
//                let id = obj.id
//                cell.imageView.image = UIImage(named: "\(id)")
            cell.backgroundColor = UIColor.systemRed
                return cell
        }
        return datasource
    }()

    // Use .absolute for exact pixel values
    // Use .fractionalWidth & .fractionalHeight for percentage of screen size.
    var layout : UICollectionViewCompositionalLayout = {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize,supplementaryItems: [])
        item.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        group.supplementaryItems = []
//        group.supplementaryItems = UICollectionReusableView

        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration.scrollDirection = .vertical
        return layout
    }()
    let client = FlickrClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStatusBar()
        setupCollectionView()
        self.applySnapshot()
//        initializeFetchedResultsController()
        self.navigationItem.searchController = searchController
        
        client.requestToken()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        client.requestToken()
    }
    
    func setupCollectionView(){
        self.collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: ImageCollectionViewCell.reuseID)
//        self.collectionView.register(PokemonTitleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PokemonTitleCollectionReusableView.identifier)
        collectionView.dataSource = self.dataSource
        self.collectionView.collectionViewLayout = self.layout
        self.collectionView.backgroundColor = .systemRed
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
      var snapshot = NSDiffableDataSourceSnapshot<Section,NSManagedObjectID>()
//        let cases = Type.allCases
//      snapshot.appendSections(cases)
//      snapshot.appendItems([])
//      dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func setupStatusBar(){
        if #available(iOS 13, *)
        {
            let statusBar = UIView(frame: (UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame)!)
            statusBar.backgroundColor = UIColor.systemBackground
            view.addSubview(statusBar)
//            UIApplication.shared.keyWindow?.addSubview(statusBar)
        }
    }

}

extension ImageSearchCollectionViewController {
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.reuseID, for: indexPath) as! PokemonTitleCollectionReusableView
//        headerView.textLabel.text = "my header"
//        return headerView
//    }
    
    
}

extension ImageSearchCollectionViewController : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
//        guard let text = searchController.searchBar.text?.lowercased(), let fetched = self.fetchedResultsController.fetchedObjects else{
//            return
//        }
//        var items : [Pokemon] = []
//        if text.count == 0{
////            items = self.originalItems
//        }else{
//            let filteredItems = fetched.filter { pokemon in
//                if let name = pokemon.name?.lowercased(){
//                    return name.contains(text)
//                }else{
//                    return false
//                }
//            }
//            items = filteredItems
//        }
//
//        var snapshot = NSDiffableDataSourceSnapshot<Type,NSManagedObjectID>()
//        snapshot.appendSections(Type.allCases)
//
//        for type in Type.allCases{
//            let itemTypes = items.filter { poke in
//                return poke.type == type.rawValue
//            }.compactMap {
//                return $0.objectID
//            }
//            snapshot.appendItems(itemTypes, toSection: type)
//        }
//        dataSource.apply(snapshot, animatingDifferences: true)

    }
    
    
}
