; ------------------------------------------------------------------------------------------------------
; Additional configuration files
; ------------------------------------------------------------------------------------------------------
[Include]
; If you were using 3DMigoto as a full modding platform for a given game
; instead of just a single stand-alone mod (e.g. facilitating mesh/texture
; replacements or other graphics mods), you can include an entire directory
; where users can extract third party mods created by others and 3DMigoto will
; include every .ini file and any external files referred to by CustomShader /
; Resource sections (Replaced shaders in these mods should still go in
; ShaderFixes for now, unless the modders want to use CustomShaders or
; ShaderRegex to keep them standalone).
;include_recursive = Mods
exclude_recursive = DISABLED*

; Uncomment to enable a custom shader that allows the stereo output mode to be
; upscaled. NOTE: uncomment only if 'upscaling' and resolution are not zero in
; the [Device] section.
;include = ShaderFixes\upscale.ini

; Uncomment to enable a custom shader that implements a software mouse cursor.
; Use in games that use a hardware cursor if you want to be able to adjust the
; stereo depth of the mouse, or to work with the below 3DVision2SBS shader.
; Note that this shader has a higher latency than the hardware cursor!
;include = ShaderFixes\mouse.ini

; Uncomment to enable a custom shader that allows the stereo output mode to be
; changed to Side-by-Side or Top-and-Bottom via the F11 key. If you are using
; SLI and this isn't working properly (partially blank or stuck image) you may
; need to also set StereoFlagsDX10 = 0x00000008 in the [Profile] section. You
; can set a default mode by altering $\ShaderFixes\3dvision2sbs.ini\mode in the
; [Constants] section:
;include = ShaderFixes\3dvision2sbs.ini


;------------------------------------------------------------------------------------------------------
; Logging options.
; Comment line or set value to 0 for no logging.
;------------------------------------------------------------------------------------------------------
[Logging]

; Log all API usage
calls=1

; Log Input key actions
input=1

; Super verbose massive log
debug=0

; Unbuffered logging to avoid missing anything at file end
unbuffered=0

; Force the CPU affinity to use only a single CPU for debugging multi-threaded
force_cpu_affinity=0

; Log NVAPI convergence modifications
convergence=0

; Log NVAPI separation modifications
separation=0

; Enable 3DMigoto's deadlock detection algorithm. If you get hangs (not
; crashes) this might help find out why.
debug_locks=0

; Enable 3DMigoto's crash handler to flush the log and write out a minidump
; file in the event the game crashes. If the game hangs rather than crashes you
; can manually invoke the handler by holding down Ctrl+Alt+F11 until you hear
; the SOS tones:
crash=0

; ------------------------------------------------------------------------------------------------------
; Command list to run on launch / after config reload.
; ------------------------------------------------------------------------------------------------------
[Constants]
; Declare named global variables here to use them from other command lists,
; [Key] bindings and [Preset]s. Named variables are namespaced so that any
; included ini files can use their own without worrying about name clashes:
;global $my_named_variable = 0.0

; Mark a variable as persist[ent] to automatically save it to the
; d3dx_user.ini on exit or F10 (config_reload). Use Ctrl+Alt+F10
; (wipe_user_config) to discard persistent values:
;global persist $some_persistent_variable = 1

; Set the initial value of "IniParams" variables, which are accessible from
; within shaders, but they are not namespaced and too many can become unwieldy:
;x = 0.8
;y = 1.0
;z = 1.2
;w = 2.0
;y1 = 3

;depthTargetIndicator
x111=0.0

; This is used by the 3DVision2SBS custom shader. To use, find the [Include]
; section above and uncomment the 'include = ShaderFixes\3dvision2sbs.ini'
; line. F11 will cycle between these modes while playing, and the current
; value will be automatically saved to the d3dx_user.ini on exit / F10:
; 0 = Regular 3D Vision
; 1 = Reversed 3D Vision
; 2 = Side by Side
; 3 = Reversed Side by Side
; 4 = Top and Bottom
; 5 = Reversed Top and Bottom
; 6 = Line interlacing
; 7 = Reversed Line interlacing
;$\ShaderFixes\3dvision2sbs.ini\mode = 0


;------------------------------------------------------------------------------------------------------
; Custom settings override for any of [convergence, separation, x, y, z, w]
;
; Four types are supported - by default the bindings will simply load the
; configured settings, but type=hold can be specified to have a preset
; active while the button is held, type=toggle can be used to make a simple
; on/off toggle, and type=cycle can be used to cycle forwards and/or backwards
; between several presets.
;
; Delays (type=hold only) and linear or cosine trasition periods (any key type)
; can be used to better synchonrise setting changes to the game's animations,
; or to smoothly adjust UI elements over a short period of time.
;
; Key bindings: For A-Z and 0-9 on the number row, just use that single
; character. For everything else (including mouse buttons), use the virtual key
; name (with or without the VK_ prefix) or hex code from this article:
; http://msdn.microsoft.com/en-us/library/windows/desktop/dd375731(v=vs.85).aspx
;
; Key combinations can be specified by separating key names with spaces, e.g.
; "Shift Q". It is also possible to indicate that a key must *not* be held for
; the binding to activate, e.g. "NO_ALT F1" would prevent the binding from
; activating when taking a 3D Screenshot with Alt F1. "NO_MODIFIERS" may be
; used as a shorthand for excluding all standard modifiers (Ctrl, Alt, Shift,
; Windows).
;
; Keys can also be from XBox controllers using:
;   XB_LEFT_TRIGGER, XB_RIGHT_TRIGGER,
;   XB_LEFT_SHOULDER, XB_RIGHT_SHOULDER,
;   XB_LEFT_THUMB, XB_RIGHT_THUMB,
;   XB_DPAD_UP, XB_DPAD_DOWN, XB_DPAD_LEFT, XB_DPAD_RIGHT,
;   XB_A, XB_B, XB_X, XB_Y, XB_START, XB_BACK, XB_GUIDE
; By default all attached controllers are used - to associate a binding with a
; specific controller add the controller number 1-4 to the prefix, like
; XB2_LEFT_TRIGGER, though this may be more useful for hunting than playing.
;
; Multiple keys may be set in a single [Key] section to allow keyboard and xbox
; controller toggles and cycles to share the same state as each other.
;------------------------------------------------------------------------------------------------------

; Example for changing default settings
;[KeyBasicExample]
;Key = z
;separation = 100.0
;convergence = 4.0
;x = 0.98
; Named variables declared in [Constants] can be set here:
;$my_named_variable = 2

; Example to support momentary hold type overrides, like aiming. Shows how to
; bind two separate buttons to the same action.
;[KeyMomentaryHoldExample]
;Key = RBUTTON
;Key = XB_LEFT_TRIGGER
;convergence = 0.1
;type = hold

; Example for a toggle override that remembers the previous value and restores
; it automatically when pressed a second time.
;[KeyToggleExample]
;Key = q
;separation = 0.1
;type = toggle
;y = 0.0

; Example for using a smart cycle type instead of a toggle. Smart is now the
; default for cycles, and when activated it will quickly check if the current
; values match its current cycle preset and resynchronise if necessary. This is
; better than type=toggle if you always want to toggle between exactly two
; values specified here, while type=toggle is better if you want to remember
; some arbitrary current value and return to it:
;[KeySmartCycleExample]
;Key = w
;type = cycle
;smart = true
;$some_variable = 0, 1

; Example for a momentary hold, but with a delay followed by a smooth
; transition (ms) on hold and release to sync better with the game. Note that
; delay only works with type=hold (for now), while transitions will work with
; all types.
;[KeyDelayAndTransitionExample]
;Key = RBUTTON
;Key = XB_LEFT_TRIGGER
;type = hold
;y = 0.25
;delay = 100
;transition = 100
;transition_type = linear
;release_delay = 0
;release_transition = 500
;release_transition_type = cosine

; Example of a cycle transition that might be used to provide several presets
; that set both convergence and UI depth to suit different scenes in a game.
; Cosine transitions are used to smooth the changes over 1/10 of a second.
; Both keyboard and Xbox controller buttons are bound to this same cycle, so
; that they can be used interchangeably and remember the same position in the
; preset list. A second key is used to cycle backwards through the presets, and
; wrapping from one end of the list to the other is disabled.
;[KeyCycleExample]
;Key = E
;Key = XB_RIGHT_SHOULDER
;Back = Q
;Back = XB_LEFT_SHOULDER
;type = cycle
;wrap = false
;convergence = 1.45, 1.13, 0.98
;z           = 0.25,  0.5, 0.75
;transition = 100
;transition_type = cosine

; Keys can only directly set variables to simple values. If you want to do
; something more advanced, you may need to call a command list from the key
; binding. type=hold/toggle keys will run the post phase of the command list on
; release.
;[KeyCommandListExample]
;key = f
;run = CommandListF
;[CommandListF]
;if $foo == 0 && cursor_showing
;	$foo = $bar * 3.14 / rt_width
;else
;	$foo = 0
;endif

; Example of a preset override that can be referenced by one or more [ShaderOverride*]
; sections which can be activated / deactivated automatically when one of the shader
; overrides is activated / deactivated. This is useful for setting automatic
; convergence for specific scene.
;[PresetExample]
;convergence = 0
;$some_variable = 1
;transition = 100
;transition_type = linear


;------------------------------------------------------------------------------------------------------
; Shader hunting options.
; Default setup is to use keyboard similar to Helix presets
;------------------------------------------------------------------------------------------------------
[Hunting]

; 0: Release mode is with shader hunting disabled, optimized for speed.
; 1: Hunting mode enabled
; 2: Hunting mode "soft disabled" - can be turned on via the toggle_hunting key
hunting=1

; Highlight mode of currently selected shader / rendertarget.
; "skip" = skip shader. don't render anything using the currently selected shader.
; "original" = fall back to original shader if the currently selected shader was patched.
; "pink" = make the output hot pink to make it standout.
; "mono" = disable stereo for the selected shader / rendertarget.
marking_mode=skip

; Cycle through available marking modes. VK_DECIMAL VK_NUMPAD0
; means hold the dot on the number pad while pressing numpad 0:
next_marking_mode = no_modifiers VK_DECIMAL VK_NUMPAD0

; What action(s) to take when marking a selected shader/buffer
; "hlsl" = decompile shader to HLSL and copy to ShaderFixes
; "asm" = disassemble shader and copy to ShaderFixes (if hlsl is disabled or failed)
; "regex" = output ShaderRegex patched shader if applicable (NOTE: Will lose associated command list)
; "clipboard" = copy shader/buffer hash to clipboard
; "mono_snapshot" = take mono screenshot (previously called mark_snapshot=1)
; "stereo_snapshot" = take stereo screenshot (previously called mark_snapshot=2)
; "snapshot_if_pink" = limit mono/stereo_snapshot to when marking_mode=pink
marking_actions = clipboard regex hlsl asm stereo_snapshot snapshot_if_pink

; Key bindings: For A-Z and 0-9 on the number row, just use that single
; character. For everything else (including mouse buttons), use the virtual key
; name (with or without the VK_ prefix) or hex code from this article:
; http://msdn.microsoft.com/en-us/library/windows/desktop/dd375731(v=vs.85).aspx
;
; XBox controllers are supported using the same bindings as the [Key] sections
; (see above). If the game already uses the first controller you might try
; using the second controller for hunting with e.g. XB2_LEFT_SHOULDER

; rotate through all VISIBLE pixel shaders at the current scene.
previous_pixelshader = no_modifiers NO_VK_DECIMAL VK_NUMPAD1
next_pixelshader = no_modifiers NO_VK_DECIMAL VK_NUMPAD2
mark_pixelshader = no_modifiers NO_VK_DECIMAL VK_NUMPAD3

; rotate through all VISIBLE vertex shaders at the current scene.
previous_vertexshader = no_modifiers NO_VK_DECIMAL VK_NUMPAD4
next_vertexshader = no_modifiers NO_VK_DECIMAL VK_NUMPAD5
mark_vertexshader = no_modifiers NO_VK_DECIMAL VK_NUMPAD6

; rotate through all USED index buffers at the current scene.
previous_indexbuffer = no_modifiers NO_VK_DECIMAL VK_NUMPAD7
next_indexbuffer = no_modifiers NO_VK_DECIMAL VK_NUMPAD8
mark_indexbuffer = no_modifiers NO_VK_DECIMAL VK_NUMPAD9

; rotate through all USED vertex buffers at the current scene.
previous_vertexbuffer = no_modifiers NO_VK_DECIMAL VK_DIVIDE
next_vertexbuffer = no_modifiers NO_VK_DECIMAL VK_MULTIPLY
mark_vertexbuffer = no_modifiers NO_VK_DECIMAL VK_SUBTRACT

; rotate through all USED render targets at the current scene.
;previous_rendertarget = no_modifiers VK_INSERT
;next_rendertarget = no_modifiers VK_HOME
;mark_rendertarget = no_modifiers VK_PAGEUP

; rotate through all USED compute shaders at the current scene.
previous_computeshader = no_modifiers VK_DECIMAL VK_NUMPAD1
next_computeshader = no_modifiers VK_DECIMAL VK_NUMPAD2
mark_computeshader = no_modifiers VK_DECIMAL VK_NUMPAD3

; rotate through all VISIBLE geometry shaders at the current scene.
previous_geometryshader = no_modifiers VK_DECIMAL VK_NUMPAD4
next_geometryshader = no_modifiers VK_DECIMAL VK_NUMPAD5
mark_geometryshader = no_modifiers VK_DECIMAL VK_NUMPAD6

; rotate through all VISIBLE domain shaders at the current scene.
previous_domainshader = no_modifiers VK_DECIMAL VK_NUMPAD7
next_domainshader = no_modifiers VK_DECIMAL VK_NUMPAD8
mark_domainshader = no_modifiers VK_DECIMAL VK_NUMPAD9

; rotate through all VISIBLE hull shaders at the current scene.
previous_hullshader = no_modifiers VK_DECIMAL VK_DIVIDE
next_hullshader = no_modifiers VK_DECIMAL VK_MULTIPLY
mark_hullshader = no_modifiers VK_DECIMAL VK_SUBTRACT

; Re-enable shaders once done with hunting:
done_hunting = NO_MODIFIERS NO_VK_DECIMAL VK_ADD

; Screenshot as pns
take_screenshot = no_modifiers VK_SNAPSHOT

; reload all fixes from ShaderFixes folder
reload_fixes = no_modifiers VK_F10

; Key to turn hunting itself on/off.  This will also show/hide overlay.
; Hunting must be set to either 1 or 2 to enable this toggle.
toggle_hunting = no_modifiers NO_VK_DECIMAL VK_NUMPAD0

; Key to reload the settings from the d3dx.ini without restarting. This can
; be the same key as reload_fixes for convenience, or a different key may be
; used to avoid resetting the ini parameters every time the shaders are
; reloaded. Note that not all settings can be reloaded, so if something doesn't
; work as expected you may still have to restart the game:
reload_config = no_modifiers VK_F10

; Deletes the d3dx_user.ini file and reloads settings to get a "clean slate"
wipe_user_config = ctrl alt no_shift VK_F10

; Hold this key to temporarily disable the fix - useful to quickly check what
; an effect looked like in the original game.
show_original = no_modifiers VK_F9

; Shows the CPU utilisation and performance impact of every active command list
monitor_performance = ctrl no_shift no_alt F9

; Freeze the current performance monitor display and log to the d3d11_log.txt
freeze_performance_monitor = no_ctrl shift no_alt F9

; Sets how often the performance monitor updates
monitor_performance_interval = 2.0

; Auto-repeat key rate in events per second.
repeat_rate=10

; Enabling this makes the overlay show the hashes of the currently selected
; shaders and index buffer during hunting. We don't actually recommend this,
; because writing down the hash from the screen is a bad habbit that tends to
; be very error prone - the recommended workflow is to dump the shaders to disk
; and check the most recently modified file in ShaderFixes, but advanced users
; can enable this if they want it:
verbose_overlay=1

; tunable parameter to use in modified shaders as variable (StereoParams.Load(int3(1,0,0)).xyzw)
; enabling tuning results in a small performance hit because the parameter texture
;tune_enable=1
;tune_step=0.1
;tune1_up=VK_INSERT
;tune1_down=VK_DELETE
;tune2_up=X
;tune2_down=Z


; Dumps out a flight log of DirectX state changes and the contents of each
; render target after every immediate draw call for the next frame. Takes up a
; large amount of space, so disabled by default.
;analyse_frame = no_modifiers VK_F8

; analyse_options specifies options for the frame analysis feature. Options can
; be combined by separating them with a space.
;
; Dumping selection (also refer to the "dump" command described below):
;        dump_rt: Dumps render targets and UAVs
;     dump_depth: Dumps depth/stencil targets
;       dump_tex: Dumps shader resources (textures)
;        dump_cb: Dumps constant buffers
;        dump_vb: Dumps vertex buffers
;        dump_ib: Dumps index buffers
;
; Texture2D format selection:
;        jpg/jps: Dumps out 2D/stereo resources as .jps files. These are the easiest
;                 to work with and don't take up as much space as DDS files, but
;                 they are not dumped for every resource and are missing some data.
;            dds: Dumps out 2D/stereo resources as .dds files. WARNING: This option
;                 may require hundreds of gigabytes and a long time! Only use it if
;                 you absolutely need more information than you can get otherwise.
;        jps_dds: Dumps out .jps when possible, .dds otherwise (default).
;           desc: Dumps out DirectX resource descriptions to .dsc files.
;
; Buffer format selection:
;            buf: Dumps out buffers as binary .buf files
;            txt: Decodes buffers as text, and includes some extra metadata not
;                 found in the .buf files. May not correctly decode all buffers.
;                 Default if dump_cb/vb/ib was specified.
;           desc: Dumps out DirectX resource descriptions to .dsc files.
;
; Misc options:
;           hold: Continue analysing subsequent frames while the key is held
;       clear_rt: Clears each render target the first time they are used in the
;                 frame. Makes it easier to see what is being drawn if the game
;                 doesn't clear them, but might cause some effects not to render.
;   filename_reg: Normally the draw number is the first part of the filename so
;                 that the files will be sorted in the order they were used in
;                 the game. Sometimes it is more desirable to examine how a
;                 specific output changed through the frame and this option will
;                 place the register number first in the filename to allow that.
;           mono: Dump out mono textures instead of stereo. To dump both, specify
;                 'mono stereo'. If neither are specified, defaults to stereo.
;  dump_on_unmap: Dumps buffers/textures whenever the game maps them to the CPU
;                 with the Map() / Unmap() calls. Typically used to update
;                 constant buffers.
; dump_on_update: Dumps buffers/textures whenever the game updates them with
;                 the UpdateSubresource() call. Alternative method used to
;                 update constant buffers.
;    share_dupes: Use a folder that is shared with subsequent frame analysis
;                 dumps for de-duplicating dumped resources. Makes future frame
;                 analysis dumps faster and use less disk space if there are a
;                 lot of identical textures, but less trivial to delete
;                 individual dump folders to reclaim disk space (i.e. all or
;                 nothing). Individual frame analysis folders are still
;                 de-duplicated regardless of this setting.
;        symlink: Try to use symbolic links when de-duplicating files in a
;                 frame analysis dump. Requires developer mode to be enabled in
;                 Windows 10, and will fall back to hard links or shortcuts
;                 when not possible. Useful to see the relationship between
;                 deduplicated files, especially when working with cygwin, but
;                 some Windows applications may behave worse when using these.
;
; Experimental Deferred Context (multi-threaded rendering) Frame Analyis Support:
;   deferred_ctx_immediate: Dumps resources from deferred contexts using the
;                 immediate context. Not suitable for dump_rt or other
;                 resources altered during the frame (by the GPU or CPU). May
;                 be ok for static unchanging resources, such as collecting HUD
;                 textures for filtering. Not thread safe - potential to crash.
;                 Recommended (not enforced) to use in conjunction with 'mono'.
;    deferred_ctx_accurate: Delays dumping resources from deferred contexts
;                 until after the GPU has updated them. Copies of *all*
;                 resources being dumped are held in memory, so it may run out
;                 - try to restrict using this option to specific resources
;                 where it is needed - preferably via the "dump" command rather
;                 than the global analyse_options. Works with 'stereo'.
;
; analyse_options can also be specified in [ShaderOverride*] sections (or other
; command lists) to set up triggers to change the options mid-way through a
; frame analysis, either for a single draw call (default), or permanently (by
; adding the 'persist' keyword).
;
; Alternatively, "dump" can be specified in a [ShaderOverride*] section (or
; any other command list) to dump specific resources with per-resource options
; (e.g. "dump = dump_tex dds share_dupes mono ps-t0"), dump resources at a
; specific point in time (e.g. "pre dump = o0") or dump a custom resource that
; frame analysis cannot otherwise see (e.g. "dump = ResourceDepthBuffer"). Use
; additional "dump" commands to dump multiple resources.
;
;analyse_options = dump_rt jps clear_rt



;------------------------------------------------------------------------------------------------------
; Chain load other wrapper DLLs instead of system DLLs.
;------------------------------------------------------------------------------------------------------
[System]

;proxy_d3d9=d3d9_helix.dll
;proxy_d3d11=d3d11_helix.dll

; We force all LoadLibrary calls back to the game folder, because games
; and nvidia both break the loading chain by going directly to System32.
; load_library_redirect=0 for off, allowing all through unchanged.
; load_library_redirect=1 for nvapi.dll override only, forced to game folder.
; load_library_redirect=2 for both d3d11.dll and nvapi.dll forced to game folder.
load_library_redirect=2

; Only enable key input processing when the game is in the foreground:
check_foreground_window=1

; Options to use hooking instead of wrapping. Used in MGSV. Possible objects to hook include:
;   deferred_contexts
;   immediate_context
;   device
;   all - all of the above
;   recommended - settings currently recommended by the 3DMigoto developers
;hook=recommended

; Options to allow ID3D11Device to be created and wrapped.  We have typically had good
; luck with returning an error for all non-dx11 requests, but some games error out
; with these checks in place.
; The allow_create_device allows D3D10 Device creation and is needed for some games.
; It has two options, allow_create_device=1, which will allow anything to go through
; without returning an error, and allow_create_device=2, which will force all requests
; to become D3D11 Devices, no matter what was passed in.
; The allow_platform_update option allows the D3D11Device1 and D3D11Context1
; interfaces introduced in Windows 8 and the platform update of Windows 7.
;
; Start with allow_check_interfaces, if that doesn't work
; then try allow_create_device=2, lastly try allow_create_device=1
;
allow_check_interface=1
allow_create_device=1
allow_platform_update=1

;------------------------------------------------------------------------------------------------------
; Settings used by the external 3DMigoto Loader
;------------------------------------------------------------------------------------------------------
[Loader]
; Target process to load into. You can optionally include part of the directory
; structure in case the game's executable name is generic.
;target = \Dead or Alive 6\DOA6.exe

; This tells the loader where to find 3DMigoto. This DLL must be located
; in the same directory as 3DMigoto Loader.exe and will be loaded in the target
; process under the same name. If d3d11.dll doesn't work try 3dmigoto.dll
;module = d3d11.dll

; Uncomment to always elevate the loader to support games that run as admin.
; This will display a UAC prompt so only enable it if you actually need it.
;require_admin = true

; Automatically launch the game from the loader. If you put the executable name
; here than the loader will need to be located in the game directory. You can
; use the full path, but that is not recommended to ship any fixes with since
; it will vary on a user's system. If the game is on Steam you can use the
; steam browser protocol to launch it, optionally passing it any command line
; arguments you need (unfortunately Steam pops a dialog to confirm command line
; parameters, which tends to end up behind other windows):
;launch = DOA6.exe
;launch = steam://run/838380/
;launch = steam://run/237850//-window-mode exclusive/

; Delay this many extra seconds after confirming that 3DMigoto was loaded in
; the target process. For games that respawn themselves or have multiple
; executables of the same name when the first process we see may not be the
; actual one we need. Set to -1 to disable automatic shut down.
;delay = 20

;------------------------------------------------------------------------------------------------------
; Settings to force display device to a specific mode.
; Uncomment a value to force the specific setting.
;------------------------------------------------------------------------------------------------------
[Device]

; (0) - disable upscaling
; (1) - enable upscaling and allows the game to disable and enable fullscreen mode
; (2) - enable upscaling and don't allow the game to switch fullscreen mode
;       (always force fullscreen). Try this if you get issues with the mouse cursor.
; Note if you enable upscaling please do not forget to:
;   1) Uncomment "run = CustomShaderUpscale" in the [Present] section,
;      otherwise you will see only a black window (with game sound).
;   2) Set a custom resolution here for width and height that the game will see.
;   3) Uncomment upscale_mode here.

; Will now auto-upscale to desktop display resolution, unless overriden by the 
; width/height below.
upscaling = 0

; Force override the screen resolution.
; If upscaling is on, the resizing functionality is disabled.
; If upscaling is on, then you MUST specify the resolution the game will be upscaled to.
; To achieve the best visual result use the native resolution of your tv or monitor.
;width = 3840
;height = 2160

; upscale_mode = 0: 3Dmigoto creates a texture and pushes it as the back buffer for the game.
; Seems to work with only few games but everything seems to run a bit smoother.
; upscale_mode = 1: 3Dmigoto creates a second swap chain and pushes the game to use it.
; Seems to work with most games. dont forget to activate upscaling shader in [present] section
;upscale_mode = 1


; overrides refresh rate set by game.
;refresh_rate=60

; filters available video modes to those providing given refresh rates.
; some games don't explicitely set the refresh rate, but use the video mode.
; use this if setting refresh_rate doesn't work.
;filter_refresh_rate=24,59,60

; full_screen=1 forces creation of full screen devices and swap chains.
; use this for 3dtvplay if game won't active stereo mode.
; full_screen=2 will also disable SetWindowPos which might help in some games.
full_screen=0

; This attempts to force exclusive full screen when this key is pressed, and
; may be useful in games where full_screen doesn't work or has undesirable side
; effects:
;force_full_screen_on_key = no_modifiers VK_F7

; This toggles forcing the full screen mode on and off. It will not take effect
; immediately, but will change what happens the next time the game tries to
; change the fullscreen mode. This is a specific hack to workaround a bug in
; Unity games, which crash when alt+tabbing out from exclusive mode fullscreen.
;
; To switch out of a Unity game without it crashing:
; Enable this option, Press F7, Alt+Enter, Alt+Tab
;toggle_full_screen = no_modifiers VK_F7

; some games explicitely disable stereo, prohibiting any stereo attempts.
; Setting this to 1 ignores all stereo disabling calls and also calls
; NvAPI_Stereo_Enable to force stereo on.
; Setting this to 2 sets 3Dmigoto to use 3D Vision Direct Mode
force_stereo = 2

; almost all DX11 games deactivate window message handling.
; setting this to 1 reenables print screen handling, alt-tab key handling etc.
allow_windowcommands=1

; Indicates where the resolution is obtained for texture hashes. Comment this
; out to never special case hashes that match the resolution or a multiple.
; Possible values are swap_chain and depth_stencil. Recommended to test which
; works for a given game (e.g. CryEngine always creates a swap chain that
; matches the native resolution so has to use depth_stencil).
get_resolution_from = large_2d_depth_stencil_if_swap_chain_native
;depth_stencil_if_swap_chain_native
;get_resolution_from = swap_chain

; This will hide the hardware mouse cursor, and will be automatically enabled
; if the software mouse configuration file is included at the top of this file.
; The hardware mouse cursor cannot be moved to depth and cannot be used in
; conjunction with the side-by-side or top-and-bottom output modes, so using a
; software mouse cursor is recommended in those cases.
; NOTE: IT IS RECOMMENDED TO RESTART THE GAME AFTER CHANGING THIS SETTING!
hide_cursor = 0

fps_monitor_interval = 1
show_fps_monitor = true
fps_show_hide = no_modifiers VK_F5

;------------------------------------------------------------------------------------------------------
; Settings for NVidia stereo driver.
;------------------------------------------------------------------------------------------------------
[Stereo]

; games which have their own stereo renderer disable the NVidia automatic
; stereo mode and render themselves into stereo buffers (Crysis 3 for example).
; Setting this to 1 disables the game stereo renderer and enables NVidia auto stereo mechanism.
; This also forces 'false' as a return for any request for NvAPI_Stereo_IsEnabled.
automatic_mode=0

; Some games (CryEngine games, for example) lock the separation & convergence
; to a specific value, which can be undesirable. Set this to 1 to ignore these
; requests from the game to unlock the separation:
unlock_separation=0
unlock_convergence=0

; games without predefined profiles can't save stereo settings.
; enabling this options automatically creates a profile for unknown games.
; Note that there is now a more flexible means to alter the game's profile -
; refer to the [Profile] section.
create_profile=0

; sets the global surface creation heuristic for NVidia stero driver.
; 0 = NVAPI_STEREO_SURFACECREATEMODE_AUTO - use driver registry profile settings for surface creation mode.
; 1 = NVAPI_STEREO_SURFACECREATEMODE_FORCESTEREO - Always create stereo surfaces.
; 2 = NVAPI_STEREO_SURFACECREATEMODE_FORCEMONO - Always create mono surfaces.
surface_createmode=0

; overrides surface creation mode for square surfaces.
;surface_square_createmode=1

; Force the NvAPI_Initialize to return an error so that games think stereo and NVidia is unavailable.
force_no_nvapi=0


;------------------------------------------------------------------------------------------------------
; Settings for GPU manipulations.
; Render settings override
;------------------------------------------------------------------------------------------------------
[Rendering]

; GPU program manipulations.

; Type of shader hashes in use:
;   3dmigoto = Traditional hash used by 3DMigoto (unseeded software FNV-1)
;   embedded = Use the first half of the MD5-like hash embedded within the
;              shaders to skip the hash calculation altogether.
;   bytecode = Only hash bytecode and signatures with hardware accelerated
;              CRC32C. Used to minimise duplicate shaders in certain games, but
;              potentially carries a higher risk of hash collisions between
;              unrelated shaders in some games (e.g. that only differ in
;              variable names). May occasionally avoid hash changes on game
;              updates due to changes in the game developer's build environment
;              (shader compiler version, build path embedded in debug info,
;              constants renamed, etc). Will not avoid hash changes if the
;              shader code, constant values, etc are changed.
shader_hash = 3dmigoto

; Switch to newer texture hashes that are less susceptible to corruption and
; don't have collisions if part of the image matches. May have a slight
; performance penalty since more of the image is hashes. Do not enable if
; upgrading an existing fix!
texture_hash=0

; Shaders in game will be replaced by these custom shaders.
override_directory=ShaderFixes

; Automatically patched shaders will be written here if caching is enabled.
cache_directory=ShaderCache

; Shaders that are directly compiled by the game, instead of binary, go here.
storage_directory=ShaderFromGame

; cache all compiled .txt shaders into .bin. this removes loading stalls.
cache_shaders=1

; Indicates whether scissor clipping should be disabled by default. A restart
; is required for this to take effect. If you need to do this on a per shader
; basis, you can use "run = BuiltInCustomShaderEnableScissorClipping" or "run =
; BuiltInCustomShaderDisableScissorClipping" from a [ShaderOverride], or define
; your own [CustomShader] section to change whatever render state you need and
; use "handling = skip" and "draw = from_caller" to transfer the draw call to
; them.
rasterizer_disable_scissor=0

; Tracks copies and updates to textures which may cause their hash to become
; out of sync with their contents - enable if texture hashes seem unreliable.
; You can also set this to 2 to disable hash contamination detection for better
; performance in hunting mode, but only do that if you are certain you won't
; be needing this in the game in question.
track_texture_updates=0

; Registers where the StereoParams and IniParams textures will be assigned -
; change if the game already uses these registers. Newly decompiled shaders
; will use the new registers, but existing shaders will not be updated - best
; workflow is to remove ShaderCache after changing these and run a search and
; replace on all shaders in ShaderFixes. Set to -1 to disable if not required.
stereo_params = 125
ini_params = 120

; Set to 1 to assemble the Input / Output / Patch Constant signature comments
; in shader assembly to allow them to be changed for passing new values between
; pipeline stages. Be careful with these comments if this is enabled - treat
; them like code! If set to 0 the assembler will use the old behaviour and
; re-use the sections from the unmodified shaders.
assemble_signature_comments = 1

; Include raw "undecipherable custom data" when disassembling shaders for
; ShaderRegex - leaving this out is for backwards compatibility with patterns
; that may not expect to see it since we didn't used to include it. Shaders
; dumped via export or hunting always include any undecipherable data.
disassemble_undecipherable_custom_data=0

; Replace constant buffer offsets with indices & components in the comment
; blocks when disassembling shaders so they match up with how they are accessed
; in the code, making things easier to follow and simplifying ShaderRegex.
patch_assembly_cb_offsets=0

; Enables more sensible behaviour when including HLSL files from subdirectories
; that themselves include other files. Also disables backwards compatibility
; where files could be specified relative to the game's working directory (i.e.
; use #include "hud.hlsl" instead of #include "ShaderFixes/hud.hlsl"). Requires
; two config reloads and a cache invalidation for changes to take effect
recursive_include = 1

;------------------------------------------------------------------------------------------------------
; Analyzation options.
;
; save all autofixed shaders as HLSL
export_fixed=0

; save all shaders sent to DX11 as ASM, or as HLSL text files if compiled by game.
export_shaders=0

; save all shaders seen as HLSL code, autofixed or not. 1= HLSL only, 2=HLSL+OriginalASM, 3=HLSL+OriginalASM+RecompiledASM
export_hlsl=0

; stores a ShaderUsage.txt file on any marking button press.
dump_usage=0

;------------------------------------------------------------------------------------------------------
; Automatic shader fixes. Those settings here apply only on newly read shaders.
; All existing *_replace.txt or *_replace.bin files are not tampered with.
; If you change settings here, the best workflow is to delete all shaders in
; the shader cache directory and let them be fixed again.

; Stereoize all shader parameters with position semantic.
fix_sv_position=0

; Pixel depth evaluation.
;fix_ZRepair_DepthTexture1=SceneDepthTexture.x
;fix_ZRepair_Dependencies1=MinZ_MaxZRatio
;fix_ZRepair_ZPosCalc1=zTex * MinZ_MaxZRatio.z - MinZ_MaxZRatio.w
;fix_ZRepair_DepthTexture2=SceneDepthTexture.x
;fix_ZRepair_Dependencies2=
;fix_ZRepair_ZPosCalc2=zTex
;fix_ZRepair_PositionTexture=PositionTexture
;fix_ZRepair_PositionCalc=1024 * %s

; Inject depth texture if other depth sources are unavailable.
;fix_ZRepair_DepthTextureHash=8a19f087b004598f

; Correct inverse transformations in pixel shaders using evaluated depth.
;fix_InvTransform=ScreenToLight,InverseTranslatedViewProjectionMatrix

; Back projection coordinate fix.
;
; Available variables in expressions:
; stereoParams.x = Separation value in range [0..1] or [-0..-1] dependent on active eye
; stereoParams.y = Convergence value in w coordinates (1/z)
; stereoParams.z = -1/1 for left/right eye
; stereoParams.w = Separation value without eye separation
; stereoTune.x = tune value 1 (default is 1)
; stereoTune.y = tune value 2 (default is 1)
; stereoTune.z = tune value 3 (default is 1)
; stereoTune.w = tune value 4 (default is 1)
; stereoScreenRes.x = Primary swap chain backbuffer horizontal resolution
; stereoScreenRes.y = Primary swap chain backbuffer vertical resolution
; zpos = current pixel z position in pixel shader
; wpos = current pixel w position in pixel shader

; Send inverse transformations from vertex shaders to pixel shaders.
;fix_BackProjectionTransform1=ScreenToTranslatedWorldMatrix._m00,ScreenToTranslatedWorldMatrix._m02,ScreenToTranslatedWorldMatrix._m01
;fix_BackProjectionTransform2=ScreenToWorld._m00,ScreenToWorld._m02,ScreenToWorld._m01

; Position variables to correct in pixel shaders.
;fix_ObjectPosition1=PointPositionAndInverseRadius
;fix_ObjectPosition1Multiplier=1, (stereoScreenRes.x/stereoScreenRes.y)*0.5, -0.5
;fix_ObjectPosition2=SpotPositionAndInverseRadius
;fix_ObjectPosition2Multiplier=1, (stereoScreenRes.x/stereoScreenRes.y)*0.5, -0.5

; Matrix multiplications to correct in pixel shaders.
;fix_MatrixOperand1=TranslatedWorldToShadowMatrix
;fix_MatrixOperand1Multiplier=1, (stereoScreenRes.x/stereoScreenRes.y)*0.5 - viewDirection.z*0.05 + (0.02791946-stereoParams.x/stereoParams.w), 0

; autofix shader option: recompiles all vertex shaders. fixes minor differences in deferred rendering.
;recompile_all_vs=0

;------------------------------------------------------------------------------------------------------
; Shader manipulations without patches + shader filtering.
;------------------------------------------------------------------------------------------------------
;[ShaderOverride1]
;Hash=69732c4f23cb6c48
; Custom stereo separation value while rendering objects using this shader.
;Separation=0
; Custom stereo convergence value while rendering objects using this
; shader (e.g. convergence=0 will move an object to infinity).
;Convergence=0
; don't draw anything using this shader.
;Handling=skip
; Use replaced shader only when there is/is not an active depth buffer (for UI filtering)
; Deprecated: use 'x = oD' instead, and test for negative zero in the shader with
; if (asint(IniParams[0].x) == asint(-0.0)) { /* depth inactive */ } else { /* depth active */ }
;depth_filter = depth_inactive
;depth_filter = depth_active
; Override a value from [Constants] when this shader is used:
;x=2.0
; Pass the dimensions of the active render target and resolution (obtained with
; get_resolution_from) into the shader:
;x1=rt_width
;y1=rt_height
;z1=res_width
;w1=res_height
; Use t0 from active pixel shader for texture filtering. Will be 0 if no
; [TextureOverride*] section exists for the texture or 1 if one does. For
; advanced filtering, set a value for filter_index in the [TextureOverride]
; section. This also works with other slot types (like o0, oD, ib, etc). Will
; be -0.0 (needs a special test) if no resource bound in this slot:
;x2 = ps-t0
; Match the partner shader (any of vs/hs/ds/gs/ps/cs). Works in much the same
; way as texture filtering - set a filter_index in the [ShaderOverride] or
; [ShaderRegex] for the partner shader you want to match and it will be set in
; this variable, or 1 = ShaderOverride/Regex matched with no filter_index, 0 =
; No ShaderOverride/Regex matched, -0.0 = No shader bound. The filter_index
; from a ShaderOverride always takes priority over any matching ShaderRegex.
;local $partner = vs
; Override the shader model to allow using newer features like Texture2DMS:
;model=vs_5_0
; Activate a preset section when this shader override is in use.
;preset = PresetExample
; Enable/disable scissor clipping for this specific shader. This is an alias
; for "run = BuiltInCustomShaderDisableScissorClipping"
; or  "run = BuiltInCustomShaderEnableScissorClipping"
;disable_scissor = 1
; There's also support for copying textures, constant buffers, depth buffers,
; etc. from one shader to another. This is a complex topic - see this page:
;    https://github.com/bo3b/3Dmigoto/wiki/Resource-Copying


;------------------------------------------------------------------------------------------------------
; On the fly regular expression shader patching engine
;------------------------------------------------------------------------------------------------------
;
; These sections define regular expressions to match against shaders and apply
; certain classes of fixes on the fly. Only assembly shaders are supported by
; this method for reliability and performance reasons.
;
; Every pattern must have a main section prefixed with ShaderRegex:
;
;[ShaderRegex1]
; shader_model is required and must be set to the types of shaders that this
; pattern will be applied against. Multiple shader models can be specified to
; match the pattern against multiple types. There are some differences in
; instructions between shader model 4 and 5 (such as in resource load
; instructions), so in some cases you may need separate patterns for each.
;shader_model = ps_4_0 ps_5_0
;
; temps is used to give names to temporary registers that you will use in the
; pattern. 3DMigoto will identify free register numbers and automatically
; adjust dcl_temps as required.
;temps = stereo tmp1
;
; This main section also acts as a command list so that you can define actions
; that will be applied on every matching shader, just as you would on any other
; command list enabled section, such as ShaderOverride, Present, etc.
;
;
; The next section of interest is the regular expression pattern. If this
; section is omitted than every shader of with matching shader_model will be
; matched (and have the command lists and InsertDeclarations processed). The
; first part of the section name must match the main ShaderRegex section you
; defined above, and it ends with ".Pattern". The regular expression grammar
; that we support is PCRE2, which is largely compatible with the powerful Perl
; and Python grammars. You can find the syntax reference here, but generally
; speaking any regular expression tutorial will give you a good primer:
;
;   http://www.pcre.org/current/doc/html/pcre2syntax.html
;
; Note that since this is parsed in an ini file that blank lines and ini
; comments are ignored, and preceding and trailing whitespace from each line
; will be stripped, so if you need to match an indented line you will need to
; explicitly match the whitespace at the start of the line with \s*
; You should also use \n to match the newline character at the end of each
; line. This should not be confused with extended mode activated by the (?x)
; switch, which will ignore *all* whitespace to allow complex patterns to be
; broken up for clarity.
;
; Multiline matching is enabled by default, as is case insensitivity (due to
; differences in the capitalisation produced by different versions of the
; disassembler), but PCRE2 provides switches for most of these options if you
; need something else.
;
; This is an example of how you might match a matrix multiply in a shader, and
; uses Python style named capture groups to pull out the registers and swizzles
; of the X and Z coordinates, and another named capture group to verify that
; the register used in the div instruction matches the one used in the multiply:
;
;[ShaderRegex1.Pattern]
;mul r\d+\.xyzw, r\d+\.yyyy, cb0\[28\]\.xyzw\n
;mad r\d+\.xyzw, (?P<pos_x>r\d+)\.(?P<swizzle_x>[xyzw])[xyzw]{3}, cb0\[27\]\.xyzw, r\d+\.xyzw\n
;mad r\d+\.xyzw, (?P<pos_z>r\d+)\.(?P<swizzle_z>[xyzw])[xyzw]{3}, cb0\[29\]\.xyzw, r\d+\.xyzw\n
;add (?P<result>r\d+)\.xyzw, r\d+\.xyzw, cb0\[30\]\.xyzw\n
;div r\d+\.[xyzw]{2}, (?P=result)\.[xyzw]{4}, r\d+\.wwww\n
;
;
; The next section specifies how to modify the matched pattern. Again the name
; must begin with the same name as the main section, and end in
; ".Pattern.Replace" (there is a reason the replacement is associated with the
; pattern, but that's coming soon). You can (and I highly encourage that you
; do) use named capture groups in the above pattern and substitute them in
; here. Temporary registers that you defined in the main ShaderRegex section
; are also available here with the same syntax as named capture groups. Use
; ${0} to indicate where the matched pattern goes, allowing you to insert code
; before and/or after it, or use additonal capture groups to insert code in the
; middle. Extended substitution is enabled in PCRE2, which among other things
; makes \n insert a newline.
;
;[ShaderRegex1.Pattern.Replace]
;\n
;// UE4 shadow correction:\n
;ld_indexable(texture2d)(float,float,float,float) ${stereo}.xyzw, l(0, 0, 0, 0), t125.xyzw\n
;add ${tmp1}.x, ${pos_z}.${swizzle_z}, -${stereo}.y\n
;mad ${pos_x}.${swizzle_x}, -${tmp1}.x, ${stereo}.x, ${pos_x}.${swizzle_x}\n
;\n
;${0}
;
;
; The final section allows you to insert new declarations into the shader, and
; 3DMigoto will check that this declaration has not already been inserted
; first. Typically this is used to get access to StereoParams in t125:
;
;[ShaderRegex1.InsertDeclarations]
;dcl_resource_texture2d (float,float,float,float) t125


;------------------------------------------------------------------------------------------------------
; texture / render target manipulations
;------------------------------------------------------------------------------------------------------
;
; NOTE: If you are trying to match a texture the same size as the resolution (or
; a /2, x2, x4 or x8 multiple), you should confirm that the same hash is used
; on different resolutions, and adjust get_resolution_from if necessary.
;
; NOTE: If you find a texture hash seems to change inconsistently, try enabling
; track_texture_updates in the [Rendering] section.
;
;[TextureOverride1]
;Hash=c3e55ebd
; NVidia stores surface creation mode heuristics in the game profile. setting
; this option overrides the creation mode for a given texture / buffer.
; 0 = NVAPI_STEREO_SURFACECREATEMODE_AUTO - use driver registry profile settings.
; 1 = NVAPI_STEREO_SURFACECREATEMODE_FORCESTEREO - create stereo surface.
; 2 = NVAPI_STEREO_SURFACECREATEMODE_FORCEMONO - create mono surface.
;StereoMode=2

;[TextureOverride2]
;Hash = e27b9d07
; Prevent the game reading from this texture - will give the game a blank
; buffer instead. Used to prevent CryEngine games falsely culling objects. Use
; the frame analysis log and look for MapType:1 to identify possible hashes.
;deny_cpu_read=1
; Expand the region copied to this texture with CopySubresourceRegion (similar
; issue to rasterizer_disable_scissor). Used to solve issues with transparent
; refraction effects (like glass) in CryEngine games.
;expand_region_copy=1

;[TextureOverrideUAVNotRT]
; Example of fuzzy matching based on attributes instead of hash. Provides an
; alternative to driver heuristics that we have more precise control over.
;match_type = Texture2D
;match_width = height * 16 / 9
;match_height = !res_height
;match_msaa = >1
;match_bind_flags = +unordered_access -render_target
;match_priority = -1
;StereoMode = 2

;------------------------------------------------------------------------------------------------------
; Example of settings override by mouse button configuration
; Mapping of from game provided hard coded convergence values to custom values
; Those are values for L.A. Noir
; Example of settings override by mouse button configuration
;------------------------------------------------------------------------------------------------------
;[ConvergenceMap]

;Map1=from 3e99999a to 0.3
;Map2=from 3f800000 to 1.0
;Map3=from 3f666666 to 0.9


;------------------------------------------------------------------------------------------------------
; Updates the game's driver profile on launch.
;
; Any changes here will require the user to OK a UAC prompt the first time they
; run the game, but the DLL tries to only do that if it is actually required.
;------------------------------------------------------------------------------------------------------
[Profile]
; This setting should always be added to a profile - it is required for a
; number of other settings to work, as well as allowing the convergence to be
; saved. If you are customising a profile you should **always uncomment this**:
StereoProfile = 1
;
; This setting enables stereo compute shaders (0x00004000), which is required
; to fix a lot of "one eye" type rendering issues in many DX11 games, and
; allows stereo2mono and the side-by-side / top-and-bottom output modes to work
; in SLI (0x00000008):
;StereoFlagsDX10 = 0x00004008
;
; This sets the default convergence in the profile. Note that 3DMigoto will
; happily override the default value from the driver, but will only override
; the user's custom convergence if it has another reason to update the profile,
; such as a change to another setting (adding a version tag to the Comments
; setting would be one way to force an update):
;StereoConvergence = 0.5
;
; This changes the green text that the driver displays, and is a good place to
; put any reminders to display to the user or just take some credit:
;Comments = "Such and such 3D fix by an awesome modder. Disable motion blur!"
;
; Change the rating: "0": 3D Vision Ready, "1": Excellent, "2": Good,
;                    "3": Fair, "4": Not Recommended
;Compat = "0"
;
; If you have added some comments, you probably want to force the green text to
; show up when the game is next run. Note that like convergence, 3DMigoto will
; only override a user setting here if something else has also been updated
; (such as Comments), so this will usually only show up the first time a user
; runs the game after installing the fix (be sure to enable StereoProfile).
;StereoMemoEnabled = 1
;
; Disable compatibility mode to make sure users are seeing the real deal. Like
; convergence, 3DMigoto will respect the users custom settings here:
;Disable2DD = 1
;
; Put a reminder in the green text of compatibility mode that they are not
; seeing the real deal:
;2DD_Notes = "Compatibility mode is enabled. To use the fix, please disable it with Ctrl+Alt+F11"
;
; These two options change which constant buffers the driver uses to pass the
; separation and convergence to any Vertex and Domain shaders it has modified.
; The default value is 12, and you may need to change it if the game already
; uses that constant buffer for any purpose, which should be apparent as you
; will see 2D geometry on any shader that uses this. You should avoid using
; these constant buffers yourself unless you understand the nuances involved.
;DX10VSCBNumber = 12
;DX10DSCBNumber = 12
;
; Workaround crashes and hangs in games that violate DirectX threading
; constraints (e.g. Resident Evil 2/7, Devil May Cry 5). Set to 1 to always
; enable workaround or 2 to only enable workaround with 3D Vision:
APP_COMPAT_SHIM = 1
;
; If a setting doesn't have a name or you don't know what it is (check the
; d3d11_log.txt for the names of all settings in this profile, or use the name
; from Nvidia Profile Inspector), you can use the hex ID (in fact, you can even
; paste a complete profile from Geforce Profile Manager - just be sure to
; delete any corrupt string settings if you do):
;0x1033cec2 = 0x00000002
;
; There are many more options, and we have tried to document them here -
; *please* edit this page if you figure out anything new:
; http://wiki.bo3b.net/index.php?title=Driver_Profile_Settings


;------------------------------------------------------------------------------------------------------
; This section defines a shortcut for unbinding all render and depth targets,
; which is commonly needed in [CustomShader] sections since all bound render
; and depth targets *must* be the same size, and leaving something else bound
; is a sure way for things to go weirdly wrong. Call it from any section that
; supports a command list with 'run = CommandListUnbindAllRenderTargets' after
; you have copied any state you need from these and before binding your own.
;------------------------------------------------------------------------------------------------------
[CommandListUnbindAllRenderTargets]
run = BuiltInCommandListUnbindAllRenderTargets

;------------------------------------------------------------------------------------------------------
; Commands to run from the Present call at the start/end of each frame
;
; Useful to clear custom resources or ini params at the start of each frame, or
; to run a custom shader to do whatever you can dream up. The post keyword will
; make an action run at the start of a frame instead of the end - as general
; guideline you want overlays drawn at the end of a frame and resources cleared
; at the start of a new frame.
;------------------------------------------------------------------------------------------------------
[Present]
; Example: Clear an ini param at the start of each frame:
;post x = 0
; Example: Undefine a custom resource until something is copied into it:
;post ResourceDepthBuffer = null
; Example: Clear a custom resource with black/zero at the start of each frame
; (beware that driver bugs may mean only one eye is cleared in some cases):
;post clear = ResourceFoo

; If you are looking for CustomShader3DVision2SBS, CustomShaderSoftwareMouse or
; CustomShaderUpscale, these are now enabled in the [Include] section at the
; top of this file instead. The other options related to these are still in
; the same place.
