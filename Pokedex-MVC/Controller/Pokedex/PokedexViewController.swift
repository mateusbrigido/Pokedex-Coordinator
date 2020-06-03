import UIKit

protocol PokedexViewControllerDelegata: AnyObject {
    func pokedexViewController(_ pokedexViewController: PokedexViewController, didSelect pokemon: Pokemon)
    func pokedexViewControllerDidTapLogin(_ pokedexViewController: PokedexViewController)
}

final class PokedexViewController: UIViewController, Storyboarded {
    @IBOutlet weak var collectionView: UICollectionView!

    private var pokedex = Pokedex.list
    
    weak var delegate: PokedexViewControllerDelegata?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Login",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(loginBarButtonItemTapped(_:)))
    }
    
    @objc func loginBarButtonItemTapped(_ sender: UIBarButtonItem) {
        delegate?.pokedexViewControllerDidTapLogin(self)
    }
    
    deinit {
        print("PokedexViewController deinitialized")
    }
}

extension PokedexViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 24, height: 85)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokedex.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as! PokemonCollectionViewCell
        
        cell.setup(with: pokedex[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pokedexViewController(self, didSelect: pokedex[indexPath.row])
    }
}

