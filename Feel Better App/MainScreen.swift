import SwiftUI
import CoreData

struct MainScreen: View {
    @State var selectedTab = "Home"
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.stackedLayoutAppearance.selected.iconColor = .purple
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.purple]
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var searchText = ""
    @State private var randomEntry: JournalEntry?
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            NavigationView {
                VStack {
                    if let randomEntry = randomEntry {
                        Image("FeelBetterLogo")
                            .resizable()
                            .scaledToFit()
                            .padding()
                        
                        Text("Welcome! Here's a random journal entry:")
                            .font(.headline)
                            .padding(.bottom, 10)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text(randomEntry.title ?? "Untitled")
                                .font(.title2)
                                .bold()
                            
                            Text(randomEntry.entry ?? "No content available.")
                                .font(.body)
                                .italic()
                            
                            if let date = randomEntry.date {
                                Text("Saved on: \(formattedDate(date))")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .padding()
                    } else {
                        Text("Welcome to Feel Better App!")
                            .font(.headline)
                            .padding(.bottom, 10)
                    }
                    
                    TextField("Search journal entries...", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    NavigationLink("Add New Journal Entry", destination: AddJournalEntryScreen())
                        .foregroundColor(.purple)
                        .padding()
                        .frame(maxWidth: 200)
                        .background(RoundedRectangle(cornerRadius: 10).stroke())
                    
                    NavigationLink("Browse Journal Entries", destination: BrowseJournalEntriesScreen())
                        .foregroundColor(.purple)
                        .padding()
                        .frame(maxWidth: 200)
                        .background(RoundedRectangle(cornerRadius: 10).stroke())
                }
                .onAppear(perform: loadRandomEntry)
                .padding()
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            .tag("Home")
            
            MoodChartView()
                .tabItem {
                    Image(systemName: "chart.bar.xaxis")
                    Text("Mood Tracker")
                }
                .tag("Mood")
            
            MeditationView()
                .tabItem {
                    Image(systemName: "apple.meditate")
                    Text("Meditation")
                }
                .tag("Meditation")
        }
    }
    
    private func loadRandomEntry() {
        let fetchRequest: NSFetchRequest<JournalEntry> = JournalEntry.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.resultType = .managedObjectResultType
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            let results = try viewContext.fetch(fetchRequest)
            randomEntry = results.first
        } catch {
            print("Failed to fetch random journal entry: \(error.localizedDescription)")
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}
