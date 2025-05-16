///
/// Safe utilities for optional `Double` values, returning `0.0` instead of `nil`.
///
/// - Example:
/// ```swift
/// let total: Double? = nil
/// print(total.orZero) // 0.0
/// ```
///
public extension Optional where Wrapped == Double {
    ///
    /// Returns the unwrapped value or `0.0` if `nil`.
    /// 
    @inlinable var orZero: Double {
        self ?? .zero
    }
}
