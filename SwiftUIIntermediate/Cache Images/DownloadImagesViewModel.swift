//
//  DownloadImagesViewModel.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 11/08/23.
//

import Foundation
import Combine

class DownloadImagesViewModel: ObservableObject {
    
    @Published var dataArray: [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    
    let dataService = PhotoModelDataService.instance
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$photoModels
            .sink { [weak self] returnedPhotoModels in
                self?.dataArray = returnedPhotoModels
                print(returnedPhotoModels)
            }
            .store(in: &cancellables)
    }
}
