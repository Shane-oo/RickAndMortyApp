//
//  RMEpisodeListViewViewModel.swift
//  RickAndMorty
//
//  Created by Shane Monck on 21/7/2023.
//

import UIKit

protocol RMEpisodeListViewViewModelDelegate: AnyObject {
    func didLoadInitialEpisodes()
    func didLoadMoreEpisodes(with newIndexPaths: [IndexPath])
    
    func didSelectEpisode(_ episode: RMEpisodeModel)

}


/// View Model to handle episode list view logic
final class RMEpisodeListViewViewModel: NSObject {
    
    public weak var delegate: RMEpisodeListViewViewModelDelegate?
    
    private var isLoadingMoreEpisodes = false

    private var isRefreshingEpisodes = false
    
    private var episodes: [RMEpisodeModel] = [] {
        didSet {
            for episode in episodes {
                let viewModel = RMCharacterEpisodeCollectionViewCellViewModel(
                    episodeUrl: URL(string: episode.url)
                )
                if(!cellViewModels.contains(viewModel)){
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    private var cellViewModels:
    [RMCharacterEpisodeCollectionViewCellViewModel] = []
    
    private var apiInfo: RMEpisodesResponseModel.Info? = nil
   
    private var nextPage = 1
    
    public var episodesRequest : RMRequestBuilder {
        return RMRequestBuilder(endpoint: .episode,
                               queryParameters:[
                                 URLQueryItem(
                                     name: "page",
                                     value: String(nextPage))]
                                )
    }
    
    public func fetchEpisodes() {
        
        RMService.shared.execute(
            episodesRequest,
            expecting: RMEpisodesResponseModel.self
        ) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info
                self?.episodes = results
                self?.apiInfo = info
                self?.nextPage += 1
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialEpisodes()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    
    /// Fetch more episodes if we have not reached the max pages
    public func fetchAdditionalEpisodes() {
        isLoadingMoreEpisodes = true
        if(nextPage <= apiInfo!.pages){
            RMService.shared.execute(
                episodesRequest,
                expecting: RMEpisodesResponseModel.self) { [weak self] result in
                    switch result {
                    case .success(let responseModel):
                        self?.nextPage += 1

                        let originalCount = self?.episodes.count ?? 0
                        let newCount = responseModel.results.count
                        let total = originalCount + newCount
                        let startingIndex = total - newCount

                        let indexPathsToAdd: [IndexPath] = Array(
                            startingIndex..<(startingIndex + newCount)
                        ).compactMap({
                            return IndexPath(row: $0, section: 0)
                        })

                        // make sure to append before didLoadMoreEpisodes
                        // that insertItems
                        self?.episodes.append(contentsOf: responseModel.results)

                        DispatchQueue.main.async {
                            // inform collection View to update cells
                            self?.delegate?.didLoadMoreEpisodes(
                                with: indexPathsToAdd
                            )
                            self?.isLoadingMoreEpisodes = false
                        }
                    case .failure(let failure):
                        print(String(describing: failure))
                        self?.isLoadingMoreEpisodes = false
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

extension RMEpisodeListViewViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? RMCharacterEpisodeCollectionViewCell else {
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

extension RMEpisodeListViewViewModel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        
        let width = (bounds.width - 30) / 2
        
        return CGSize(width: width,
                      height: width * 0.8)
    }
}

extension RMEpisodeListViewViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let episode = episodes[indexPath.row]
        
        delegate?.didSelectEpisode(episode)
    }
}

// MARK: - ScrollView
extension RMEpisodeListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        guard !cellViewModels.isEmpty else {
            return
        }
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        
        // Determine if the user is at the top and dragging to refresh
        if offsetY < 0 && scrollView.isDragging && !isRefreshingEpisodes {
            print("User is at the top and dragging to refresh")
            // Add your refresh logic here
            // i dont have any
            
            // Set isRefreshing flag to true to prevent multiple refresh triggers
            isRefreshingEpisodes = true
        }
        
        
        // Determine if the user is at the bottom and dragging to load more data
        if offsetY > 0 && offsetY > contentHeight - scrollViewHeight
            && scrollView.isDragging && !isLoadingMoreEpisodes {
            
            // Add your load more data logic here
            fetchAdditionalEpisodes()
        }
        
    }
    
}
