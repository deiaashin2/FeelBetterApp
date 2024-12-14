//
//  AddJournalEntryScreen.swift
//  Feel Better App
//
//  Created by Sadia Khan on 11/19/24.
//

import SwiftUI
import PhotosUI

struct AddJournalEntryScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var entry = ""
    @State private var photos: Data?
    @State private var videos: Data?
    @State private var showPhotoPicker = false
    @State private var showVideoPicker = false
    @State private var selectedImage: UIImage?
    @State private var selectedVideoURL: URL?

    var body: some View {
        Form {
            Section(header: Text("Journal Details")) {
                TextField("Title", text: $title)
                TextEditor(text: $entry)
                    .frame(height: 150)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
            }

            Section(header: Text("Attachments")) {
                Button("Add Photo") {
                    showPhotoPicker = true
                }
                Button("Add Video") {
                    showVideoPicker = true
                }
            }

            Button("Save") {
                addJournalEntry()
            }
        }
        .navigationTitle("Add Journal Entry")
        .sheet(isPresented: $showPhotoPicker) {
            PhotoPicker(selection: $selectedImage)
        }
        .sheet(isPresented: $showVideoPicker) {
            VideoPicker(selection: $selectedVideoURL)
        }
        .onChange(of: selectedImage) { newValue in
            if let image = newValue {
                photos = image.pngData()
            }
        }
        .onChange(of: selectedVideoURL) { newValue in
            if let videoURL = newValue {
                do {
                    videos = try Data(contentsOf: videoURL)
                } catch {
                    print("Error loading video data: \(error.localizedDescription)")
                }
            }
        }
    }

    private func addJournalEntry() {
        let newEntry = JournalEntry(context: viewContext)
        newEntry.title = title
        newEntry.entry = entry
        newEntry.date = Date()
        newEntry.photos = photos
        newEntry.videos = videos

        do {
            try viewContext.save()
            dismiss()
        } catch {
            print("Failed to save entry: \(error.localizedDescription)")
        }
    }
}

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selection: UIImage?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker

        init(_ parent: PhotoPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            if let itemProvider = results.first?.itemProvider,
               itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                    DispatchQueue.main.async {
                        self.parent.selection = image as? UIImage
                    }
                }
            }
        }
    }
}

struct VideoPicker: UIViewControllerRepresentable {
    @Binding var selection: URL?
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.movie"], in: .import)
        documentPicker.delegate = context.coordinator
        return documentPicker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let parent: VideoPicker
        
        init(_ parent: VideoPicker) {
            self.parent = parent
        }
    }
}
