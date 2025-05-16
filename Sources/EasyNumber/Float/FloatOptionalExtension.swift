///
/// Safe utilities for optional `Float` values, returning `0.0` instead of `nil`.
///
/// - Example:
/// ```swift
/// let temperature: Float? = nil
/// print(temperature.orZero) // 0.0
/// ```
///
public extension Optional where Wrapped == Float {
    ///
    /// Returns the unwrapped value or `0.0` if `nil`.
    /// 
    @inlinable var orZero: Float {
        self ?? .zero
    }
}
