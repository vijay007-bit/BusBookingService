//
//  ViewController.swift
//  BusBookingService
//
//  Created by MAC on 03/08/22.
//

import UIKit

class SeatSelectionVC: UIViewController {
    
    @IBOutlet weak var paymentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var paymentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var ladiesView: UIView!
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var bookedView: UIView!
    @IBOutlet weak var stopsView: UIView!
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var availableView: UIView!
    @IBOutlet weak var ticketPriceLabel: UILabel!
    @IBOutlet weak var totalFare: UILabel!
    
    
    // variable declaration
    var row = 0
    var column = 0
    var busData: Bus?
    
    //variable to get the vacant cell index
    var rowData = 0
    
    // data manipulated array
    var busArray: [CombineSeat] = []
    
    //selected array data
    var selectedArray:[CombineSeat] = []{
        didSet{
            //payment view manipulation and lebel update
            if selectedArray.count == 0{
                paymentView.isHidden = true
            }else{
                paymentView.isHidden = false
                self.ticketPriceLabel.text = busData?.data?.finalTotalFare ?? ""
                self.totalFare.text = "\((Int(busData?.data?.finalTotalFare ?? "") ?? 0) * selectedArray.count)"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Mark :-  SettingUp Initial UI
        initialSetup()
    }
    
    // initial ui setup function
    func initialSetup(){
        self.navigationController?.setStatusBar(backgroundColor: UIColor(named: ColorSet.background.color)!)
        self.navigationController?.navigationBar.isHidden = true
        homeView.TopLeftTopRightCornerRound(radius: 20)
        stopsView.TopRightCornerRound(radius: 10)
        ladiesView.TopLeftTopRightCornerRound(radius: 5)
        selectedView.TopLeftTopRightCornerRound(radius: 5)
        bookedView.TopLeftTopRightCornerRound(radius: 5)
        availableView.TopLeftTopRightCornerRound(radius: 5)
        collectionView.register(UINib(nibName: Cell.seat.nib, bundle: nil), forCellWithReuseIdentifier: Cells.seat.identifier)
        collectionView.register(UINib(nibName: Cell.header.nib, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Cells.header.identifier)
        busData = BundleDecoder.decodeBusBundleJson()
        paymentView.isHidden = true
        dataManipulationByBusType(busLayout: busData?.data?.buslayoutID?.layout ?? "", isLastRowSeatHidden: true)
    }
    
    func dataManipulationByBusType(busLayout busType: String, isLastRowSeatHidden: Bool){
        let value = busType.split(separator: "X")
        let clearSpaceX = Int(value[0].replacingOccurrences(of: " ", with: "")) ?? 0
        let clearSpaceY = Int(value[1].replacingOccurrences(of: " ", with: "")) ?? 0
        self.column = clearSpaceX + clearSpaceY + 1
        let total = (Int(self.busData?.data?.buslayoutID?.maxSeats ?? "") ?? 0) % (clearSpaceX + clearSpaceY)
        let minRow = (Int(self.busData?.data?.buslayoutID?.maxSeats ?? "") ?? 0) / (clearSpaceX + clearSpaceY)
        total > 1 ? (self.row = minRow + 1) : (self.row = minRow)
        let data = Array((busData?.data?.buslayoutID?.combineSeats ?? []).joined())
        let loopLimit = isLastRowSeatHidden ? ((Int(self.busData?.data?.buslayoutID?.maxSeats ?? "") ?? 0) + row - 1) : ((Int(self.busData?.data?.buslayoutID?.maxSeats ?? "") ?? 0) + row - 2)
        for j in 0...loopLimit{
            let condition = isLastRowSeatHidden ? (j == clearSpaceX || ((j % column) == clearSpaceX)) : (j == clearSpaceX || (((j % column) == clearSpaceX) && (rowData != row - 1)))
            if condition{
                isLastRowSeatHidden ? (rowData = rowData + 1) : ((rowData < (row - 1)) ? (rowData = rowData + 1) : (rowData = rowData))
                busArray.append(CombineSeat(bus: nil, type: nil, seatNo: nil, isLadies: nil, seatStatus: nil))
            }else{
                busArray.append(data[j - rowData])
            }
        }
    }
    
    
}

//MARK: - Collection view data population and conditions

extension SeatSelectionVC:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    // setting section to one to make a single header for driver seat
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // no of seat count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.busArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.seat.identifier, for: indexPath) as! SeatCell
        // condition for vacant cell hiding components and disabling button tap
        busArray[indexPath.row].isLadies == nil ?  vacantCellSetup(cell) :  normalCellSetup(cell, indexPath: indexPath)
        return cell
    }
    
    // setting up headers view
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Cells.header.identifier, for: indexPath)
        return view
    }
    
    // setting up dynamic height and width for cells for all cases
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = column
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        let final =  (column == 4) ? CGSize(width: size, height: 80) :  CGSize(width: size, height: 60)
        return final
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
    }
    
    func vacantCellSetup(_ cell: SeatCell){
        cell.seatLabel.isHidden = true
        cell.seatView.isHidden = true
        cell.seatSelectionBtn.isHidden = true
    }
    
    func normalCellSetup(_ cell: SeatCell, indexPath: IndexPath){
        // condition for populate cell
        let item = indexPath.item
        cell.seatView.isHidden = false
        cell.seatLabel.isHidden = true
        // checking for cell is already selected or not
        let isSelected = selectedArray.contains { $0 == busArray[item] ? true : false }
        // if cell is already selected so making it selected
        if isSelected{
            cell.seatLabel.isHidden = false
            !(self.busArray[item].isLadies ?? false) ? (cell.seatView.backgroundColor = UIColor(named: ColorSet.selected.color)) : (cell.seatView.backgroundColor = UIColor(named: ColorSet.ladies.color))
            cell.seatLabel.text =  self.busArray[item].seatNo ?? ""
            handleSelectionFunctionality(cell, item: item)
        }else{
            // if cell is not selected then run default conditions
            // if confition for checking ladies seat and if it was booked
            if ((busArray[item].isLadies ?? false) && (busArray[item].seatStatus?.rawValue ?? "") == "book"){
                cell.seatView.backgroundColor = UIColor(named: ColorSet.ladies.color)
            }else if ((( busArray[item].seatStatus?.rawValue ?? "") == "empty") || ((busArray[item].isLadies ?? false) && (busArray[item].seatStatus?.rawValue ?? "") == "empty")){
                (busArray[item].isLadies ?? false) ? (cell.seatView.backgroundColor = UIColor(named: ColorSet.ladies.color)) : (cell.seatView.backgroundColor = UIColor(named: ColorSet.available.color))
                // creating tap action because seats are available
                handleSelectionFunctionality(cell, item: item)
                
            }else{
                cell.seatView.backgroundColor = UIColor(named: ColorSet.booked.color)
            }
        }
    }
    
    // handle selection functionality
    func handleSelectionFunctionality(_ cell: SeatCell, item: Int){
        // condition for checking the seats not booked
        cell.seatSelectionBtn.isHidden = false
        cell.callBackSeatSelected = { [weak self] in
            guard let self = self else{ return }
            debugPrint("btn tapped = \(self.busArray[item])")
            // checking condition if seats are selected or not
            if cell.seatLabel.isHidden{
                cell.seatLabel.isHidden = false
                if !(self.busArray[item].isLadies ?? false){
                    cell.seatView.backgroundColor = UIColor(named: ColorSet.selected.color)
                }
                cell.seatLabel.text =  self.busArray[item].seatNo ?? ""
                self.selectedArray.append(self.busArray[item])
            }else{
                // condition if seats are selected
                cell.seatLabel.isHidden = true
                if !(self.busArray[item].isLadies ?? false){
                    cell.seatView.backgroundColor = UIColor(named: ColorSet.available.color)
                }
                for (index,value) in self.selectedArray.enumerated(){
                    if value.seatNo == self.busArray[item].seatNo{
                        self.selectedArray.remove(at: index)
                    }
                }
            }
        }
    }
}




