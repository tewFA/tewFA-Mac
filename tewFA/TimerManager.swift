//
//  TimerManager.swift
//  tewFA
//
//  Created by ash on 2/23/25.
//

import SwiftUI

class TimerManager: ObservableObject {
    @Published var countdownTime: Int = 30
    var timer: Timer?

    // Start the 2FA countdown timer
    func start2FATimer() {
        syncTimerWithOTP() // Update immediately with initial time
        updateTitleBarTimer() // Update the title bar immediately
        // Set up the timer to tick every second
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(syncTimerWithOTP), userInfo: nil, repeats: true)
    }

    // Sync the countdown timer with the OTP expiration window
    @objc func syncTimerWithOTP() {
        let currentTime = Int(Date().timeIntervalSince1970) // Current Unix timestamp (seconds since 1970)
        countdownTime = 30 - (currentTime % 30)  // Calculate the remaining time in the current 30-second window

        if countdownTime == 0 {
            refreshTokens()  // Refresh OTP tokens when a new window starts
        }

        updateTitleBarTimer()  // Update the title bar with the remaining time
    }

    // Update the title bar with the current countdown time
    func updateTitleBarTimer() {
        // Use the current view's window title for the timer display (you can modify this logic to suit your UI)
        if let window = NSApplication.shared.windows.first {
            window.title = "tewFA (\(countdownTime)s)"
        }
    }

    // Refresh the tokens when the countdown reaches 0
    func refreshTokens() {
        // Logic to refresh or reset your OTP tokens for 2FA
        print("Refreshing 2FA tokens...")
        // You could call a function to regenerate new tokens or re-fetch from the server
    }
}
