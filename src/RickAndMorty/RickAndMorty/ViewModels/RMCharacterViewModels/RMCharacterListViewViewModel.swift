//
//  RMCharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Shane Monck on 2/7/2023.
//

import UIKit

protocol RMCharacterListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath])
    
    func didSelectCharacter(_ character: RMCharacterModel)

}


/// View Model to handle character list view logic
final class RMCharacterListViewViewModel: NSObject {
    
    public weak var delegate: RMCharacterListViewViewModelDelegate?
    
    private var isLoadingMoreCharacters = false
    private var isRefreshingCharacters = false
    
    private var characters: [RMCharacterModel] = [] {
        didSet {
            for character in characters {
                let viewModel = RMCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image))
                if(!cellViewModels.contains(viewModel)){
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []
    
    private var apiInfo: RMCharactersResponseModel.Info? = nil
   
    private var nextPage = 1
    
    public var charactersRequest : RMRequestBuilder {
        return RMRequestBuilder(endpoint: .character,
                               queryParameters:[
                                 URLQueryItem(
                                     name: "page",
                                     value: String(nextPage))]
                                )
    }
    
    public func fetchCharacters() {
        
        RMService.shared.execute(
            charactersRequest,
            expecting: RMCharactersResponseModel.self
        ) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info
                self?.characters = results
                self?.apiInfo = info
                self?.nextPage += 1
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    
    /// Fetch more characters if we have not reached the max pages
    public func fetchAdditionalCharacters() {
        isLoadingMoreCharacters = true
        if(nextPage != apiInfo?.pages){
            RMService.shared.execute(
                charactersRequest,
                expecting: RMCharactersResponseModel.self) { [weak self] result in
                    switch result {
                    case .success(let responseModel):
                        self?.nextPage += 1
                        
                        let originalCount = self?.characters.count ?? 0
                        let newCount = responseModel.results.count
                        let total = originalCount + newCount
                        let startingIndex = total - newCount
                        
                        let indexPathsToAdd: [IndexPath] = Array(
                            startingIndex..<(startingIndex + newCount)
                        ).compactMap({
                            return IndexPath(row: $0, section: 0)
                        })

                        // make sure to append before didLoadMoreCharacters
                        // that insertItems
                        self?.characters.append(contentsOf: responseModel.results)

                        DispatchQueue.main.async {
                            // inform collection View to update cells
                            self?.delegate?.didLoadMoreCharacters(
                                with: indexPathsToAdd
                            )
                            self?.isLoadingMoreCharacters = false
                        }
                    case .failure(let failure):
                        print(String(describing: failure))
                        self?.isLoadingMoreCharacters = false
                    }
                    
                }
        }
        // else {
        // remove loader as there is no more data
        //}
    }

    
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
}

// MARK: - Collection View

extension RMCharacterListViewViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? RMCharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        
        let viewModel = cellViewModels[indexPath.row]
        cell.configure(with: viewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
                for: indexPath) as? RMFooterLoadingCollectionReusableView else {
            fatalError("Unsupported")
        }
        
        footer.startAnimating()
        
        return footer
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

extension RMCharacterListViewViewModel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        
        let width = (bounds.width - 30) / 2
        
        return CGSize(width: width,
                      height: width * 1.5)
    }
}

extension RMCharacterListViewViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let character = characters[indexPath.row]
        
        delegate?.didSelectCharacter(character)
    }
}

// MARK: - ScrollView
extension RMCharacterListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        guard !cellViewModels.isEmpty else {
            return
        }
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        
        // Determine if the user is at the top and dragging to refresh
        if offsetY < 0 && scrollView.isDragging && !isRefreshingCharacters {
            print("User is at the top and dragging to refresh")
            // Add your refresh logic here
            // i dont have any
            
            // Set isRefreshing flag to true to prevent multiple refresh triggers
            isRefreshingCharacters = true
        }
        
        
        // Determine if the user is at the bottom and dragging to load more data
        if offsetY > 0 && offsetY > contentHeight - scrollViewHeight
            && scrollView.isDragging && !isLoadingMoreCharacters {
            
            // Add your load more data logic here
            fetchAdditionalCharacters()
        }
        
    }
    
}
