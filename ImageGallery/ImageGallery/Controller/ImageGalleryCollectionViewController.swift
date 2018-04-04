//
//  ImageGalleryCollectionViewController.swift
//  ImageGallery
//
//  Created by John on 3/27/18.
//  Copyright © 2018 John. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ImageCell"

protocol ErrorHandlerForImageGallery: class {
    func noImageData(for cell: UICollectionViewCell)
}


class ImageGalleryCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,
    UICollectionViewDragDelegate, UICollectionViewDropDelegate, UICollectionViewDelegateFlowLayout,
    ErrorHandlerForImageGallery, UIDropInteractionDelegate, DataForImageGallery {
    
    weak var imageGallery: ImageGallery! {
        didSet {
            
        }
    }
    
    func noImageData(for cell: UICollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell) {
            imageGallery.images.remove(at: indexPath.item)
            collectionView.deleteItems(at: [indexPath])
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource  = self
            collectionView.delegate = self
            collectionView.dropDelegate = self
            collectionView.dragDelegate = self
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.minimumInteritemSpacing = 1
                layout.minimumLineSpacing = 1
            }
            collectionView.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(scaleCollectionViewCells(with:))))
        }
    }
    
    private var scaleForCollectionViewCell: CGFloat = 1.0
    
    @objc func scaleCollectionViewCells(with recognizer: UIPinchGestureRecognizer) {
        switch recognizer.state {
            case .changed, .ended:
                scaleForCollectionViewCell *= recognizer.scale
                recognizer.scale = 1
                collectionView.collectionViewLayout.invalidateLayout()
            default:
                break
        }
    }
    
    @IBOutlet weak var trashBarButtonItem: UIBarButtonItem! {
        didSet {
            navigationController?.navigationBar.addInteraction(UIDropInteraction(delegate: self))
        }
    }
    
    var trashBarButtonView: UIView {
        return (trashBarButtonItem.value(forKey: "view") as? UIView) ?? UIView()
    }
    
    // canHandle
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self)
    }
    
    // sessionDidUpdate
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        let dropPoint = session.location(in: self.trashBarButtonView)
        let width = trashBarButtonView.bounds.width
        let heigth = trashBarButtonView.bounds.height
        if abs(dropPoint.x) < width/2 && dropPoint.y < heigth {
            return UIDropProposal(operation: .move)
        }
        return UIDropProposal(operation: .cancel)
    }
    
    private var indexPathsForDragging: [IndexPath] = []
    
    // performDrop
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        for indexPath in indexPathsForDragging.sorted().reversed() {
            self.imageGallery.images.remove(at: indexPath.item)
            self.collectionView.deleteItems(at: [indexPath])
        }
        indexPathsForDragging = []
    }
    
    override func viewDidLoad() {
        navigationItem.title = "Image Gallery: " + (imageGallery?.name ?? " undefined")
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
    }
    
    // MARK: Navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let cell = sender as? ImageCollectionViewCell {
            return cell.image != nil
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination.contents as? ImageViewController else { return }
        if let cell = sender as? ImageCollectionViewCell {
            vc.transferedImage = cell.imageView.image
        }
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageGallery != nil ? imageGallery.images.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        if let cell = cell as? ImageCollectionViewCell {
            cell.image = imageGallery.images[indexPath.item].image
            cell.url = imageGallery.images[indexPath.item].url
            cell.errorHandler = self
        }
        return cell
    }
    
    // not called with local drag and drop, unlike in a tableView drag and drop operation
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let imageData = imageGallery.images.remove(at: sourceIndexPath.item)
        imageGallery.images.insert(imageData, at: destinationIndexPath.item)
    }
    
    // will be called with local drag and drop
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // UICollectionViewLayout
    // layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let aspectRatio = imageGallery.images[indexPath.item].aspectRatio
        let cellHeigth: CGFloat = 200 * scaleForCollectionViewCell / aspectRatio
        return CGSize(width: 200 * scaleForCollectionViewCell, height: cellHeigth)
    }
    
    // MARK: UICollectionViewDragDelegate methods
    // itemsForBeginning
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        indexPathsForDragging = []
        return dragItems(at: indexPath)
    }
    
    // itemsForAddingTo
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        session.localContext = collectionView
        return dragItems(at: indexPath)
    }
    
    // For external dropping images
    func dragItems(at indexPath: IndexPath) -> [UIDragItem] {
        if let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell, let image = cell.image  {
            indexPathsForDragging += [indexPath]
            let dragItemImage = UIDragItem(itemProvider: NSItemProvider(object: image))
            dragItemImage.localObject = image
            return [dragItemImage]
        }
        return []
    }
    
    // MARK: UICollectionViewDropDelegate methods
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        let isLocalSession = session.localDragSession != nil
        return session.canLoadObjects(ofClass: UIImage.self) && (isLocalSession || session.canLoadObjects(ofClass: NSURL.self))
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession,
                        withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal{
        let isLocalSession = session.localDragSession != nil
        return UICollectionViewDropProposal(operation: isLocalSession ? .move : .copy, intent: .insertAtDestinationIndexPath)
    }
    
    // a minor deviation from the assignment: here the initial image is used, and later updated through the url
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        var destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
        for item in coordinator.items {
            if let sourceIndexPath = item.sourceIndexPath {
                collectionView.performBatchUpdates({
                    let imageData = imageGallery.images[sourceIndexPath.item]
                    imageGallery.images.remove(at: sourceIndexPath.item)
                    collectionView.deleteItems(at: [sourceIndexPath])
                    imageGallery.images.insert(imageData, at: destinationIndexPath.item)
                    collectionView.insertItems(at: [destinationIndexPath])
                })
                coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
            } else {
                // no sourceIndexPath, so not local
                let placeholderContext: UICollectionViewDropPlaceholderContext? = coordinator.drop(
                    item.dragItem,
                    to: UICollectionViewDropPlaceholder(insertionIndexPath: destinationIndexPath, reuseIdentifier: "DropPlaceHolderCell")
                )
                var imageDataForCell = ImageGallery.ImageData()
                item.dragItem.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (provider, error) in
                    if let image = provider as? UIImage {
                        imageDataForCell.image = image
                    } else {
                        return
                    }
                })
                item.dragItem.itemProvider.loadObject(ofClass: NSURL.self, completionHandler: { [weak self] (provider, error) in
                    if let imageURL = (provider as? URL)?.imageURL {
                        DispatchQueue.main.async {
                            placeholderContext?.commitInsertion(dataSourceUpdates: { (insertionIndexPath) in
                                imageDataForCell.url = imageURL
                                self?.imageGallery?.images.insert(imageDataForCell, at: insertionIndexPath.item)
                            })
                            placeholderContext?.deletePlaceholder()
                        }
                    }
                })
            }
        }
    }
    
}
