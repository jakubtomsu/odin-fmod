package fmod_fsbank

error_string :: proc(result: RESULT) -> string {
    // odinfmt: disable
    switch result {
        case .OK:                          return "No errors."
        case .ERR_CACHE_CHUNKNOTFOUND:     return "An expected chunk is missing from the cache, perhaps try deleting cache files."
        case .ERR_CANCELLED:               return "The build process was cancelled during compilation by the user."
        case .ERR_CANNOT_CONTINUE:         return "The build process cannot continue due to previously ignored errors."
        case .ERR_ENCODER:                 return "Encoder for chosen format has encountered an unexpected error."
        case .ERR_ENCODER_INIT:            return "Encoder initialization failed."
        case .ERR_ENCODER_NOTSUPPORTED:    return "Encoder for chosen format is not supported on this platform."
        case .ERR_FILE_OS:                 return "An operating system based file error was encountered."
        case .ERR_FILE_NOTFOUND:           return "A specified file could not be found."
        case .ERR_FMOD:                    return "Internal error from FMOD sub-system."
        case .ERR_INITIALIZED:             return "Already initialized."
        case .ERR_INVALID_FORMAT:          return "The format of the source file is invalid."
        case .ERR_INVALID_PARAM:           return "An invalid parameter has been passed to this function."
        case .ERR_MEMORY:                  return "Run out of memory."
        case .ERR_UNINITIALIZED:           return "Not initialized yet."
        case .ERR_WRITER_FORMAT:           return "Chosen encode format is not supported by this FSB version."
        case .WARN_CANNOTLOOP:             return "Source file is too short for seamless looping. Looping disabled."
        case .WARN_IGNORED_FILTERHIGHFREQ: return "FSBANK_BUILD_FILTERHIGHFREQ flag ignored: feature only supported by XMA format."
        case .WARN_IGNORED_DISABLESEEKING: return "FSBANK_BUILD_DISABLESEEKING flag ignored: feature only supported by XMA format."
        case .WARN_FORCED_DONTWRITENAMES:  return "FSBANK_BUILD_FSB5_DONTWRITENAMES flag forced: cannot write names when source is from memory."
        case .ERR_ENCODER_FILE_NOTFOUND:   return "External encoder dynamic library not found."
        case .ERR_ENCODER_FILE_BAD:        return "External encoder dynamic library could not be loaded, possibly incorrect binary format, incorrect architecture, or file corruption."
    }
    // odinfmt: enable
    return "Unknown error"
}
