 extension msg on int {
 String get statusCodeErrorMessage {
    return switch (this) {
      300 => 'Multiple choices. The requested resource has multiple options.',
      301 => 'Moved permanently. '
          'The requested resource has been assigned a new permanent URL.',
      302 => 'Found. '
          'The requested resource has been temporarily moved to a different URL.',
      303 => 'See other. '
          'The response to the request can be found under a different URL.',
      304 => 'Not modified. '
          'The requested resource has not been modified since the last retrieval.',
      305 => 'Use proxy. '
          'The requested resource must be accessed through the proxy specified in the location header.',
      307 => 'Temporary redirect. '
          'The requested resource has been temporarily moved to a different URL.',
      308 =>
        'Permanent redirect. The requested resource has been permanently moved to a different URL.',
      400 => "Request couldn't be processed due to invalid format. "
              'Please check your request.',
      401 => 'Access denied. Reauthentication may be required.',
      403 => 'Access forbidden. Required permissions are missing.',
      404 =>
        "The requested resource couldn't be found. Please verify your request.",
      405 => 'Invalid request method. Please verify and try again.',
      406 => "Server couldn't fulfill the request in the requested format.",
      407 => 'Proxy authentication required. Please check your proxy settings.',
      408 => 'Request timed out. Server response exceeded expected time limit.',
      409 => "Request conflict with the server's current state.",
      410 => 'Requested resource is no longer available on the server.',
      411 => 'Length of content was not specified in the request.',
      412 => 'Request precondition failed. '
          'Header fields might have been evaluated to false.',
      413 => 'Request payload is too large for the server to process.',
      414 => "Requested URI exceeds the server's length limit.",
      415 => 'Unsuported media type in the request entity.',
      416 => 'Requested range could not be supplied by the server.',
      429 => 'Rate limit exceeded due to too many requests.',
      451 => 'Resource unavailable due to legal reasons.',
      500 => 'Internal server error. An issue occurred on our side.',
      501 => 'Server lacks the required functionality.',
      502 =>
        'Encountered a bad gateway. Please ensure the server URL is correct.',
      503 => 'Server temporarily unable to handle the request.',
      504 => 'Gateway timeout. Server connection exceeded time limit.',
      505 => 'HTTP version in the request is not supported by the server.',
      506 => 'Server has encountered an internal configuration error.',
      507 =>
        'Server unable to store the representation to complete the request.',
      508 =>
        'Infinite loop detected by the server while processing the request.',
      510 => 'Additional extensions to the request are required to fulfill it.',
      _ =>
        'An unexpected error occurred. We appreciate your patience.',
    };
  }}