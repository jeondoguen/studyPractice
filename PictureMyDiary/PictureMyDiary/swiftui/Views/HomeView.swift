//
//  HomeView.swift
//  iReceipt
//
//  Created by Federico on 26/01/2022.
//
//
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var imageData : ImageData
    
    var body: some View {
        List {
            ForEach(imageData.imageNote) { note in
                NavigationLink(destination: NoteDetailView(note: note)) //작성화면으로 넘어감
                {
                    HStack {
                        Image(uiImage: UIImage(data: note.image)!)
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                        
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .lineLimit(2)
                        }
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ImageData())
    }
}
