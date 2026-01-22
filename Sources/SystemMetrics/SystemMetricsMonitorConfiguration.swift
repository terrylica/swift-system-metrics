//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift System Metrics API open source project
//
// Copyright (c) 2025 Apple Inc. and the Swift System Metrics API project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of Swift System Metrics API project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

extension SystemMetricsMonitor {
    /// The configuration that controls the behavior of the system metrics monitor.
    public struct Configuration: Sendable {
        /// The default system metrics monitor configuration.
        ///
        /// See individual property documentation for specific default values.
        public static let `default`: Self = .init()

        /// The interval between system metrics data scraping.
        ///
        /// The default interval is 15 seconds.
        public var interval: Duration

        /// String labels associated with the metrics
        public var labels: Labels

        /// Additional dimensions attached to every metric
        package let dimensions: [(String, String)]

        /// Create new monitor configuration.
        ///
        /// - Parameters:
        ///     - interval: The interval at which system metrics should be updated, defaults to 15 seconds.
        public init(
            pollInterval interval: Duration = .seconds(15)
        ) {
            self.interval = interval
            self.labels = Labels()
            self.dimensions = []
        }

        /// Creates a new configuration.
        ///
        /// - Parameters:
        ///     - interval: The interval at which system metrics should be updated.
        ///     - labels: The labels to use for generated system metrics.
        ///     - dimensions: The dimensions to include in generated system metrics.
        package init(
            pollInterval interval: Duration = .seconds(15),
            labels: Labels,
            dimensions: [(String, String)] = []
        ) {
            self.interval = interval
            self.labels = labels
            self.dimensions = dimensions
        }
    }
}

extension SystemMetricsMonitor.Configuration {
    /// Labels for the reported system metrics data.
    ///
    /// Backend implementations can provide a static extension with
    /// defaults that suit their specific backend needs.
    public struct Labels: Sendable {
        /// Label for virtual memory size in bytes.
        public var virtualMemoryBytes: String = "process_virtual_memory_bytes"
        /// Label for resident memory size in bytes.
        public var residentMemoryBytes: String = "process_resident_memory_bytes"
        /// Label for process start time since UNIX epoch in seconds.
        public var startTimeSeconds: String = "process_start_time_seconds"
        /// Label for total user and system CPU time spent in seconds.
        public var cpuSecondsTotal: String = "process_cpu_seconds_total"
        /// Label for maximum number of open file descriptors.
        public var maxFileDescriptors: String = "process_max_fds"
        /// Label for number of open file descriptors.
        public var openFileDescriptors: String = "process_open_fds"

        /// Create a new `Labels` instance with default values.
        public init() {}

        /// Create a new `Labels` instance.
        ///
        /// - Parameters:
        ///     - prefix: Prefix for all other labels.
        ///     - virtualMemoryBytes: Label for virtual memory size in bytes
        ///     - residentMemoryBytes: Label for resident memory size in bytes.
        ///     - startTimeSeconds: Label for process start time since UNIX epoch in seconds.
        ///     - cpuSecondsTotal: Label for total user and system CPU time spent in seconds.
        ///     - maxFileDescriptors: Label for maximum number of open file descriptors.
        ///     - openFileDescriptors: Label for number of open file descriptors.
        package init(
            prefix: String,
            virtualMemoryBytes: String,
            residentMemoryBytes: String,
            startTimeSeconds: String,
            cpuSecondsTotal: String,
            maxFileDescriptors: String,
            openFileDescriptors: String
        ) {
            self.virtualMemoryBytes = prefix + virtualMemoryBytes
            self.residentMemoryBytes = prefix + residentMemoryBytes
            self.startTimeSeconds = prefix + startTimeSeconds
            self.cpuSecondsTotal = prefix + cpuSecondsTotal
            self.maxFileDescriptors = prefix + maxFileDescriptors
            self.openFileDescriptors = prefix + openFileDescriptors
        }
    }
}
