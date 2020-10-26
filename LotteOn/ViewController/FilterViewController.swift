//
//  FilterViewController.swift
//  LotteOn
//
//  Created by mmxsound on 2020/10/25.
//

import UIKit
import RangeSeekSlider

//의존성을 줄이기위해 델리게이트로 데이터 전달
protocol FilterViewControllerDelegate: class {
    func bindView(productListViewModel: ProductListViewModel)
}

//setting Value for collectionView Padding
fileprivate let minimumLineSpacing: CGFloat = 10
fileprivate let minimumInteritemSpacing: CGFloat = 0
fileprivate let insectPadeding: CGFloat = 0

class FilterViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet var slider: RangeSeekSlider!
    @IBOutlet var minPriceLabel: UILabel!
    @IBOutlet var maxPriceLabel: UILabel!
    @IBOutlet var searchButton: UIButton!
    
    var viewModel: ProductListViewModel!

    weak var delegate: FilterViewControllerDelegate?
    
    @IBAction func touchedSearchButton(sender: Any) {
        delegate?.bindView(productListViewModel: self.viewModel)
        self.dismiss(animated: true, completion: {
        })
    }
    
    @IBAction func touchedCloseButton(sender: Any) {
        self.viewModel.reset()
        delegate?.bindView(productListViewModel: self.viewModel)
        self.dismiss(animated: true, completion: {
        })
    }
    
    @IBAction func touchedRefreshButton(sender: Any) {
        self.viewModel.reset()
        DispatchQueue.main.async {
            self.changeButtonTitle()
            self.setPrice()
            self.slider.minValue = CGFloat(self.viewModel.minPrice)
            self.slider.maxValue = CGFloat(self.viewModel.maxPrice)
            self.collectionView.reloadData()
            self.slider.layoutIfNeeded()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCollectionView()
        self.slider.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        delegate?.bindView(productListViewModel: self.viewModel)
        super.viewDidAppear(animated)
    }
    
    private func setCollectionView() {
        let nib = UINib(nibName: "MallSelectionCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "MallSelectionCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

    }
    
    private func changeButtonTitle() {
        let orderList = viewModel.orderBy(sortType: viewModel.sortType)
        let filterCount = viewModel.filterBy(currentMall: orderList).count
        DispatchQueue.main.async {
            self.searchButton.setTitle("\(filterCount)개의 상품보기", for: .normal)
        }
    }
    
    private func setPrice() {
        self.slider.minValue = CGFloat(self.viewModel.minPrice)
        self.slider.maxValue = CGFloat(self.viewModel.maxPrice)
        self.slider.selectedMinValue = CGFloat(self.viewModel.selectedMinPrice)
        self.slider.selectedMaxValue = CGFloat(self.viewModel.selectedMaxPrice)
        self.slider.minDistance = CGFloat(self.viewModel.selectedMinPrice)
        self.slider.maxDistance = CGFloat(self.viewModel.selectedMaxPrice)

        let min = Double(self.viewModel.selectedMinPrice)
        let max = Double(self.viewModel.selectedMaxPrice)
        self.minPriceLabel.text = "\(min.withCommas()) 원"
        self.maxPriceLabel.text = "\(max.withCommas()) 원"
    }
}

//MARK: BindableType
extension FilterViewController: Bindable {
    
    func bindViewModel() {
        DispatchQueue.main.async {
            self.changeButtonTitle()
            self.setPrice()
            self.collectionView.reloadData()
            self.collectionView.layoutIfNeeded()
            self.collectionViewHeight.constant = self.collectionView.contentSize.height
        }
    }
}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension FilterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let viewModel = self.viewModel else {
            return 0
        }
        return viewModel.mallList.count
    }
    
    //MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MallSelectionCell", for: indexPath) as? MallSelectionCell else {
            return UICollectionViewCell()
        }
        
        guard let viewModel = self.viewModel else {
            return UICollectionViewCell()
        }

        let selectionModel = MallSectionViewModel(mallInfo: viewModel.mallList[indexPath.row])
        cell.bind(to: selectionModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let bool = self.viewModel.mallList[indexPath.row].mallSelect ?? false
        self.viewModel.mallList[indexPath.row].mallSelect = !bool
        self.changeButtonTitle()
        self.collectionView.reloadData()
    }
    
}

//MARK: UICollectionViewDelegateFlowLayout
extension FilterViewController: UICollectionViewDelegateFlowLayout {
    
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
        let label = UILabel(frame: CGRect.zero)
        label.text = self.viewModel.mallList[indexPath.row].mallName
        label.sizeToFit()
        let cellSize = label.frame
        return CGSize(width: cellSize.width + 40, height: cellSize.height + 20)
    }
}

extension FilterViewController: RangeSeekSliderDelegate {
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        
        //1000단위 절삭
        var min = Int(minValue) / 1000 * 1000
        var max = Int(maxValue) / 1000 * 1000
        
        if min == 0 {
            min = Int(self.viewModel.minPrice)
        }
        
        if maxValue == CGFloat(self.viewModel.maxPrice) {
            max = Int(self.viewModel.maxPrice)
        }
        
        self.viewModel.selectedMinPrice = Double(min)
        self.viewModel.selectedMaxPrice = Double(max)

        self.minPriceLabel.text = "\(Double(min).withCommas()) 원"
        self.maxPriceLabel.text = "\(Double(max).withCommas()) 원"
        self.changeButtonTitle()
    }
}
