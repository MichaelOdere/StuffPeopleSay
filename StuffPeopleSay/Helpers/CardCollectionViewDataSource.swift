import UIKit

protocol CardCollectionViewDelegate: class {
    var d:Deck { get }
    var cardView:CardEditView { get }
}

protocol CardSearchCollectionViewDelegate: class {
    func isFiltering()->Bool
    var filteredCards:[Card] { get }
//    var selectedDecks:[String] { get }
}

class CardCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    weak var delegate:CardCollectionViewDelegate?
    weak var searchDelegate:CardSearchCollectionViewDelegate?

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sd = searchDelegate {
            if sd.isFiltering(){
                return searchDelegate!.filteredCards.count
            }
        }
        if let delegate = delegate {
            return delegate.d.cards.count
        }
        return 0    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        var card = delegate?.d.cards[indexPath.row]

        if let sd = searchDelegate {
            if sd.isFiltering() {
                card = sd.filteredCards[indexPath.row]
            }
        }
        
        cell.state = .selected
        cell.name.isEnabled = false
        cell.name.id = card?.id
        cell.name.text = card?.name
        cell.name.indexPath = indexPath
        //        cell.name.addTarget(self, action: #selector(textChanged(sender:)), for: UIControlEvents.editingChanged)
        cell.name.delegate = delegate?.cardView
        return cell
    }
}
