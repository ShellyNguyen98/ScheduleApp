//
//  CalenderWeekListView.swift
//  SchedulePal
//
//  Created by Shawn Shirazi on 2/6/23.
//

import SwiftUI

struct CalenderWeekListView<Day: View, Header: View, Title: View, WeekSwitcher: View>: View {
    var calender: Calendar
    @Binding var date: Date
    let content: (Date) -> Day
    let header: (Date) -> Header
    let title: (Date) -> Title
    let weekSwitcher: (Date) -> WeekSwitcher
    
    let daysInWeek = 7
    
    @State private var filterSelection = 0

    
    init(
        calender: Calendar,
        date: Binding<Date>,
        @ViewBuilder content: @escaping (Date) -> Day,
        @ViewBuilder header: @escaping (Date) -> Header,
        @ViewBuilder title: @escaping (Date) -> Title,
        @ViewBuilder weekSwitcher: @escaping (Date) -> WeekSwitcher
    ) {
        self.calender = calender
        self._date = date
        self.content = content
        self.header = header
        self.title = title
        self.weekSwitcher = weekSwitcher
        UITableView.appearance().backgroundColor = .clear
    }
    
    let persistentContainer = CoreDataManager.shared.persistenceContainer
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        let month = date.startOfMoneth(using: calender)
        let days = makeDays()
                                
        ZStack {
            //BACKGROUND
            Color(.systemGray6)
                .edgesIgnoringSafeArea(.all)
            
            //CALENDER
                ScrollView() {
                    VStack(alignment: .leading, spacing: 20) {
                        VStack {
                            HStack {
                                self.title(month)
                                self.weekSwitcher(month)
                            }
                            HStack(spacing: 30) {
                                ForEach(days.prefix(daysInWeek), id: \.self, content: header)
                            }
                            HStack(spacing: 30) {
                                ForEach(days, id: \.self) { date in
                                    content(date)
                                    
                                }
                            }
                        }
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(38.5)
                        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                        
                        ProgressBarView()
                        
                        //APPOINTMENTS
                        HStack {
                            Text("Filter by: ")
                            Spacer()
                            Picker("", selection: $filterSelection) {
                                Text("Time").tag(0)
                                Text("Priority").tag(1)
                            }
                            .pickerStyle(.segmented)
                            .frame(width: 200)
                            
                        }
                        .padding(.horizontal)
                        
                        HStack() {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 25, height: 25)
                                .padding(.trailing)
                            VStack(alignment: .leading) {
                                Text("1:00 PM")
                                Text("Meeting with Matt")
                            }
                            Spacer()
                        }
                        .padding()
                        .frame(width: UIScreen.screenWidth / 1.1)
                        .background(Color(.white))
                        .cornerRadius(38.5)
                        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                                                
                        Text("Done for the day")
                            .padding(.horizontal)
                        
                        ZStack {
                            HStack() {
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 25, height: 25)
                                    .padding(.trailing)
                                VStack(alignment: .leading) {
                                    Text("8:00 AM")
                                    Text("Walk dog")
                                }
                                Spacer()
                            }
                            .padding()
                            .frame(width: UIScreen.screenWidth / 1.1)
                            .background(Color(.white))
                            .cornerRadius(38.5)
                            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                            
                            HStack {
                                Spacer()
                                
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.system(size: 30))
                                    .padding(.bottom, 50)
                            }
                                
                            
//                            Divider()
//                                .padding(.horizontal)
//                                .frame(height: 5)
//                                .overlay(.black)

                        }
                        
                        
                    }
                    .padding()
                }
                .padding(.top, 80)
                .background(Color(.systemGray6))

        
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    Button {
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.black)
                                .frame(width: 50, height: 50)
                            
                            Image(systemName: "plus")
                                .font(.system(size: 26))
                                .foregroundColor(Color.white)
                        }

                    }

                }
                .padding(.bottom, 80)
            }
            .padding()
        
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)


        
    }
    
    func isSameDay(date1: Date,date2: Date)->Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
}
//struct CalenderWeekListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalenderWeekListView()
//    }
//}
