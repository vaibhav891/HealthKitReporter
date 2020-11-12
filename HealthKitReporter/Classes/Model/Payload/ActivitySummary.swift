//
//  ActivitySummary.swift
//  HealthKitReporter
//
//  Created by Victor on 25.09.20.
//

import Foundation
import HealthKit

public struct ActivitySummary: Identifiable {
    public struct Harmonized: Codable {
        public let activeEnergyBurned: Double
        public let activeEnergyBurnedGoal: Double
        public let activeEnergyBurnedUnit: String
        public let appleExerciseTime: Double
        public let appleExerciseTimeGoal: Double
        public let appleExerciseTimeUnit: String
        public let appleStandHours: Double
        public let appleStandHoursGoal: Double
        public let appleStandHoursUnit: String
    }

    public let identifier: String
    public let date: String?
    public let harmonized: Harmonized

    public init(activitySummary: HKActivitySummary) throws {
        self.identifier = ActivitySummaryType
            .activitySummaryType
            .original?
            .identifier ?? "HKActivitySummaryType"
        self.date = activitySummary
            .dateComponents(for: Calendar.current)
            .date?
            .formatted(with: Date.iso8601)
        self.harmonized = try activitySummary.harmonize()
    }
}
