//
//  ViewController.swift
//  LotteOn
//
//  Created by mmxsound on 2020/10/25.
//

import UIKit

//setting Value for collectionView Padding
fileprivate let minimumLineSpacing: CGFloat = 20
fileprivate let minimumInteritemSpacing: CGFloat = 12
fileprivate let insectPadeding: CGFloat = 16

class ViewController: UIViewController {

    var viewModel: ProductListViewModel!
    //
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var countLabel: UILabel!
    
    @IBAction func touchedSortButton(sender: Any) {
        self.setActionSheet()
    }
    
    @IBAction func touchedFilterButton(sender: Any) {
        if var filterViewController = self.storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as? FilterViewController {
            filterViewController.bind(to: self.viewModel)
            filterViewController.delegate = self
            self.navigationController?.present(filterViewController, animated: true, completion: { })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCollectionView()
    }

    private func setCollectionView() {
        let nib = UINib(nibName: "CustomCollectionCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "CustomCollectionCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    private func reloadCollectionView() {
        DispatchQueue.main.async {
            let orderList = self.viewModel.orderBy(sortType: self.viewModel.sortType)
            let filterList = self.viewModel.filterBy(currentMall: orderList)
            self.countLabel.text = "총 \(filterList.count) 개"
            self.collectionView.reloadData()
            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredVertically, animated: true)
        }
    }
    
    private func setActionSheet() {

        let alertController = UIAlertController(title: nil, message: "정렬 기준을 선택하세요.", preferredStyle: .actionSheet)

        let rankAction = UIAlertAction(title: "랭킹순", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.viewModel.sortType = .rank
            self.reloadCollectionView()
        })
        let ascendPriceAction = UIAlertAction(title: "낮은가격순", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.viewModel.sortType = .descendPrice
            self.reloadCollectionView()
        })
        let descendPriceAction = UIAlertAction(title: "높은가격순", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.viewModel.sortType = .ascendPrice
            self.reloadCollectionView()
        })
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        alertController.addAction(rankAction)
        alertController.addAction(ascendPriceAction)
        alertController.addAction(descendPriceAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

//MARK: BindableType
extension ViewController: Bindable {
    
    func bindViewModel() {
        self.reloadCollectionView()
    }
}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let viewModel = self.viewModel else {
            return 0
        }
        let orderList = viewModel.orderBy(sortType: viewModel.sortType)
        return viewModel.filterBy(currentMall: orderList).count
    }
    
    //MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionCell", for: indexPath) as? CustomCollectionCell else {
            return UICollectionViewCell()
        }
        
        guard let viewModel = self.viewModel else {
            return UICollectionViewCell()
        }
        let orderList = viewModel.orderBy(sortType: viewModel.sortType)
        let filterList = viewModel.filterBy(currentMall: orderList)
        let productViewModel = ProductViewModel(product: filterList[indexPath.row])
        cell.bind(to: productViewModel)
        return cell
    }
    
}

//MARK: UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout
                            collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: insectPadeding, bottom: 0, right: insectPadeding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let space: CGFloat = minimumInteritemSpacing + (insectPadeding * 2)
        let screenSize = UIScreen.main.bounds
        return CGSize(width: (screenSize.width - space) / 2, height: CGFloat(250).getRatio())
    }
}

//MARK: FilterViewControllerDelegate
extension ViewController: FilterViewControllerDelegate {
    func bindView(productListViewModel: ProductListViewModel) {
        self.viewModel = productListViewModel
        self.reloadCollectionView()
    }
}
