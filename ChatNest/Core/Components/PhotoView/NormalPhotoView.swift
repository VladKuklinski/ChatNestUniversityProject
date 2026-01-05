//
//  CircularPhotoView.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 01/08/2025.
//

import SwiftUI

struct NormalPhotoView: View {
    let user = User.mockUser
    let size : ImageSize
    var body: some View {
        
        if let image = user.imageUrl {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: size.size, height: size.size)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: size.size, height: size.size)
                .clipShape(Circle())
        }
    }
}




