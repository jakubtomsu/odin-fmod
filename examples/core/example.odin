package fmod_core_example

import "core:fmt"
import "core:math/linalg"
import rl "vendor:raylib"
import "core:sys/windows"
import fmod "../../fmod/core"

// Based on the '3D' example from FMOD core

DISTANCEFACTOR :: 1000.0 // Units per meter.  I.e feet would = 3.28.  centimeters would = 100.

_main :: proc() -> fmod.RESULT {
    WIDTH :: 800
    HEIGHT :: 480
    rl.InitWindow(WIDTH, HEIGHT, "FMOD Core Example")
    defer rl.CloseWindow()
    rl.SetTargetFPS(60)

    system: ^fmod.SYSTEM

    windows.CoInitializeEx(nil, .APARTMENTTHREADED)

    fmod.System_Create(&system, fmod.VERSION) or_return
    fmod.System_Init(system, 100, fmod.INIT_NORMAL, nil) or_return
    fmod.System_Set3DSettings(system, 1.0, DISTANCEFACTOR, 1.0) or_return

    sound1: ^fmod.SOUND
    sound2: ^fmod.SOUND

    fmod.System_CreateSound(system, "drumloop.wav", fmod.MODE_3D, nil, &sound1) or_return
    fmod.System_CreateSound(system, "swish.wav", fmod.MODE_2D, nil, &sound2) or_return

    fmod.Sound_Set3DMinMaxDistance(sound1, 0.5 * DISTANCEFACTOR, 5000 * DISTANCEFACTOR) or_return

    channel1: ^fmod.CHANNEL
    channel2: ^fmod.CHANNEL

    pos1: fmod.VECTOR = 0

    fmod.System_PlaySound(system, sound1, nil, true, &channel1) or_return
    fmod.Channel_Set3DAttributes(channel1, pos1, 0) or_return
    fmod.Channel_SetPaused(channel1, false) or_return

    camera: rl.Camera3D = {
        position = {10, 10, 10},
        target = 0,
        up = {0, 1, 0},
        fovy = 45,
        projection = .PERSPECTIVE,
    }

    for !rl.WindowShouldClose() {
        delta := clamp(rl.GetFrameTime(), 1.0 / 240.0, 1.0 / 10.0)

        prev_pos := camera.position
        if rl.IsMouseButtonDown(.LEFT) {
            rl.UpdateCamera(&camera, .FREE)
        }

        // Note: we should pass forward and up vector from the camera here.        
        fmod.System_Set3DListenerAttributes(
            system,
            0,
            cast(fmod.VECTOR)camera.position,
            cast(fmod.VECTOR)(camera.position - prev_pos) * (1000.0 / delta),
            {0, 0, 1},
            {0, 1, 0},
        ) or_return

        if rl.IsKeyPressed(.F) {
            fmod.System_PlaySound(system, sound2, nil, false, &channel2) or_return
        }

        fmod.System_Update(system) or_return

        rl.BeginDrawing()
        rl.ClearBackground({30, 40, 50, 255})

        rl.BeginMode3D(camera)
        {
            rl.DrawCube(0, 2.0, 2.0, 2.0, rl.RED)
            rl.DrawCubeWires(0, 2.0, 2.0, 2.0, rl.MAROON)
            rl.DrawGrid(10, 1.0)
        }
        rl.EndMode3D()

        rl.DrawFPS(2, 2)
        rl.DrawText("Press F to play swish.wav", 2, 24, 20, rl.WHITE)

        rl.EndDrawing()
    }

    fmod.Sound_Release(sound1) or_return
    fmod.Sound_Release(sound2) or_return

    fmod.System_Close(system) or_return
    fmod.System_Release(system) or_return

    windows.CoUninitialize()

    return .OK
}

main :: proc() {
    res := _main()
    fmt.println("Result:", fmod.error_string(res))
}
