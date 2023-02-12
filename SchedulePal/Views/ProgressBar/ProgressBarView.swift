//
//  ProgressBarView.swift
//  SchedulePal
//
//  Created by Shawn Shirazi on 2/8/23.
//

import SwiftUI

struct ProgressBarView: View {
    @State private var tasksCompleted = 0.0
    @State var completed: Int = 0
    var totalTasks = 10.0

    var body: some View {
        VStack {
            ProgressView("Tasks Completed", value: tasksCompleted, total: totalTasks)
                .accentColor(.green)
                .onChange(of: completed, perform: { newValue in
                    if tasksCompleted < 10 {
                        tasksCompleted += 1
                    }
                })
            
            Button("Tap to finish task") {
                completed += 1
            }
            

        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView()
    }
}
