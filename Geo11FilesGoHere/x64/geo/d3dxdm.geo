; ------------------------------------------------------------------------------------------------------
; Additional configuration files
; ------------------------------------------------------------------------------------------------------
[Include]

;------------------------------------------------------------------------------------------------------
[Constants]


;------------------------------------------------------------------------------------------------------
[Device]

; direct_mode: choose stereo output option based on hardware
;   nvidia_dx9
;	nvidia_dx11
;	tab
;	tab_reversed
;	sbs
;	sbs_reversed
;	interlaced
;	interlaced_reversed
direct_mode = nvidia_dx11

matrix_analyzer = 1
auto_detect_depth_buffer = 1
resolve_msaa_depth_buffers = 1
preserve_depth_buffers = 1
dm_deferred_context_queue_per_eye = 0
repeat_command_list_depth_buffer_stats = 0

fps_monitor_interval = 1
show_fps_monitor = true
; fps_show_hide = no_modifiers VK_F5

;------------------------------------------------------------------------------------------------------
[Stereo]
dm_stereo_enabled = 1
dm_convergence = 3.0
dm_separation = 80
dm_hud_detection = 0
;dm_hud_depth_override = -1.0
dm_auto_convergence = 0
dm_auto_convergence_uav_buffer_updates = 1
dm_hud_depth_max_offset_in = 0.002

dm_min_convergence = 0.1
dm_max_convergence_soft = 6.0
dm_max_convergence_hard = 8.0
dm_popout_bias = 0.02
dm_slow_convergence_rate = 5.0
dm_slow_convergence_threshold_near = 0.0
dm_slow_convergence_threshold_far = 0.0
dm_instant_convergence_threshold = 4.0
dm_anti_judder_threshold = 0.5
dm_auto_convergence_hud_enabled = 1
dm_auto_convergence_hud_timeout = 2.0
dm_warn_no_z_buffer = 1
dm_patching_mode = 0
dm_auto_scissor_rect = 0
dm_auto_convergence_post_present = 1

;------------------------------------------------------------------------------------------------------
; Settings for GPU manipulations.
; Render settings override
;------------------------------------------------------------------------------------------------------
[Rendering]
override_directory_dm=ShaderFixesDM
dm_auto_patch_failure_path = DMAutoPatchFailures
dm_auto_patch_cache_path = DMAutoPatchCache
dm_auto_patch_cache_auto_scissor_path = AutoScissor
dm_auto_patch_cache_hud_path = Hud

; Automatically patched shaders will be written here if caching is enabled.
cache_directory_dm=ShaderCacheDM

[Constants]
global $increaseconvergence = 0
global $decreaseconvergence = 0
global $increaseseparation = 0
global $decreaseseparation = 0
global $showoverlaystereoparams = 0
global $hideoverlaystereoparamstime = 0

[PresetIncreaseConvergence]
condition = ($increaseconvergence == 1 && autoconvergence_enabled == 0)
convergence = convergence * 1.05
transition = 100
transition_type = cosine

[PresetDecreaseConvergence]
condition = ($decreaseconvergence == 1 && autoconvergence_enabled == 0 && convergence > 0.25)
convergence = convergence * 0.95
transition = 100
transition_type = cosine

[PresetIncreaseSeparation]
condition = ($increaseSeparation == 1)
separation = separation + 1
transition = 50
transition_type = cosine

[PresetDecreaseSeparation]
condition = ($decreaseseparation == 1)
separation = separation - 1
transition = 50
transition_type = cosine

[Present]
preset = PresetIncreaseConvergence
preset = PresetDecreaseConvergence
preset = PresetIncreaseSeparation
preset = PresetDecreaseSeparation
if $showoverlaystereoparams
	show_stereo_params = 1
	$hideoverlaystereoparamstime = -1
else
	if $increaseSeparation || $decreaseseparation || (($increaseconvergence || $decreaseconvergence) && !autoconvergence_enabled)
		show_stereo_params = 1
		$hideoverlaystereoparamstime = time
	else if $hideoverlaystereoparamstime == -1
		show_stereo_params = 0
	else if $hideoverlaystereoparamstime + 2.0 < time
		show_stereo_params = 0
		$hideoverlaystereoparamstime = -1
	endif
endif

[KeyToggleOverlayStereoParams]
Key = shift F6
type = toggle
$showoverlaystereoparams = 1

[KeyIncreaseConvergence]
Key = ctrl F6
type = hold
$increaseconvergence = 1

[KeyDecreaseConvergence]
Key = ctrl F5
type = hold
$decreaseconvergence = 1

[KeyIncreaseSeparation]
Key = ctrl F4
type = hold
$increaseSeparation = 1

[KeyDecreaseSeparation]
Key = ctrl F3
type = hold
$decreaseseparation = 1

