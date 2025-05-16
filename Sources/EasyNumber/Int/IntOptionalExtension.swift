///
/// Safe utilities for optional `Int` values, reducing the need for manual unwrapping.
///
/// Provides a fallback of `.zero` when the value is `nil`.
///
/// - Example:
/// ```swift
/// let value: Int? = nil
/// print(value.orZero) // 0
/// ```
///
public extension Optional where Wrapped == Int {
    ///
    /// Returns the unwrapped value or `0` if `nil`.
    ///
    @inlinable var orZero: Int {
        self ?? .zero
    }
}
