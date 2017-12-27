import UIKit

class DeckCollectionViewLayout: UICollectionViewLayout {
   
    fileprivate var numberOfColumns = 2
    fileprivate var cellPadding: CGFloat = 10
    
    fileprivate var contentHeight: CGFloat = 0
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        cache.removeAll()
        guard let collectionView = collectionView else {
            return
        }
        let cellWidth:CGFloat = contentWidth / CGFloat(numberOfColumns)
        let cellHeight:CGFloat = contentWidth / CGFloat(numberOfColumns)
        
        var xOffset = [CGFloat]()
        var yOffset = [CGFloat]()
        var currentXOffset:CGFloat = 0
        
        for _ in 0 ..< numberOfColumns {
            
            xOffset.append(currentXOffset)
            yOffset.append(0)
            
            currentXOffset += cellWidth
        }
        
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            
            let xOffIndex = item % numberOfColumns
            let yOffIndex = xOffIndex
            let frame = CGRect(x: xOffset[xOffIndex], y: yOffset[yOffIndex], width: cellWidth, height: cellHeight)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            // Creates an UICollectionViewLayoutItem with the frame and add it to the cache
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            // Updates the collection view content height
            contentHeight = max(contentHeight,frame.maxY)
            yOffset[yOffIndex] = yOffset[yOffIndex] + cellHeight
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}

