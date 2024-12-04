dumpbin /exports fmod/core/lib/windows/x64/fmod_vc.lib > fmod_core_windows_x64_exports.txt
dumpbin /exports fmod/core/lib/windows/x64/fmodL_vc.lib > fmod_core_windows_x64_exports_debug.txt

dumpbin /exports fmod/fsbank/lib/windows/x64/fmodL_vc.lib > fmod_fsbank_windows_x64_exports_debug.txt
dumpbin /exports fmod/fsbank/lib/windows/x64/fmod_vc.lib > fmod_fsbank_windows_x64_exports.txt

dumpbin /exports fmod/studio/lib/windows/x64/fmod_vc.lib > fmod_studio_windows_x64_exports.txt
dumpbin /exports fmod/studio/lib/windows/x64/fmodL_vc.lib > fmod_studio_windows_x64_exports_debug.txt