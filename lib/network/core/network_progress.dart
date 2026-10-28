/// Transfer progress emitted while request bytes are prepared or response
/// bytes are consumed.
///
/// When the server omits `Content-Length`, total byte counts (and therefore
/// fractions) remain unknown. Consumers should display an indeterminate
/// progress indicator in that case.
class NetworkProgress {
  /// Creates a progress snapshot. [sent] and [received] are cumulative byte
  /// counts for the current stage.
  const NetworkProgress({
    required this.sent,
    required this.received,
    this.totalSent,
    this.totalReceived,
    this.stage = NetworkProgressStage.response,
  });

  /// Request bytes prepared/sent so far, when measurable.
  final int sent;

  /// Response bytes consumed so far.
  final int received;

  /// Total request bytes, if known before sending.
  final int? totalSent;

  /// Total response bytes from the response headers, if provided.
  final int? totalReceived;

  /// Indicates whether the snapshot describes request or response transfer.
  final NetworkProgressStage stage;

  /// Upload fraction in `0..1`, or null when the total size is unknown.
  double? get uploadFraction => totalSent == null || totalSent == 0
      ? null
      : (sent / totalSent!).clamp(0, 1);

  /// Download fraction in `0..1`, or null when the total size is unknown.
  double? get downloadFraction => totalReceived == null || totalReceived == 0
      ? null
      : (received / totalReceived!).clamp(0, 1);
}

/// Part of the HTTP transfer represented by [NetworkProgress].
enum NetworkProgressStage { request, response }
