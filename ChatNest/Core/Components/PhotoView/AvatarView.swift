//
//  AvatarView.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 04/09/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct AvatarView: View {
    @EnvironmentObject var profileViewModel : ProfileViewModel
    let tempImage: Image?
    let imageUrl: String?
    let size: ImageSize
    
    var body: some View {
        
        if let tempImage = tempImage {
            tempImage
                .resizable()
                .scaledToFill()
                .frame(width: size.size, height: size.size)
                .clipShape(Circle())
        } else if let urlString = imageUrl,
                  let url = URL(string: urlString) {
            WebImage(url: url, options: [.refreshCached]) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: size.size, height: size.size)
                    .clipShape(Circle())
                    .id(urlString)
            } placeholder: {
                if let tempImage = tempImage {
                    tempImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: size.size, height: size.size)
                        .clipShape(Circle())
                } else {
                    ProgressView()
                        .scaledToFill()
                        .frame(width: size.size, height: size.size)
                        .clipShape(Circle())
                }
            }
            .onSuccess { _,_,_ in
                DispatchQueue.main.async {
                    if tempImage != nil {
                        profileViewModel.tempImage = nil
                    }
                }
            }
        } else {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .foregroundStyle(.green)
                .scaledToFill()
                .frame(width: size.size, height: size.size)
                .clipShape(Circle())
        }
    }
}



