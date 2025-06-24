outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

workspace "GLFW"
   architecture "x86_64"
   configurations { "Debug", "Release" }

project "GLFW"
   kind "StaticLib"
   language "C"
   staticruntime "On"
   location "."

   targetdir ("bin/"    .. outputdir .. "/%{prj.name}")
   objdir    ("bin-int/".. outputdir .. "/%{prj.name}")

   includedirs { "include", "src" }

   files {
      "include/GLFW/glfw3.h",
      "include/GLFW/glfw3native.h",
      "src/context.c",
      "src/init.c",
      "src/input.c",
      "src/monitor.c",
      "src/platform.c",
      "src/vulkan.c",
      "src/window.c",
      "src/egl_context.c",
      "src/osmesa_context.c",
   }

   filter "system:linux"
      pic "On"
      systemversion "latest"
      staticruntime "On"
      defines { "_GLFW_X11" }
      files {
         "src/x11_init.c",
         "src/x11_monitor.c",
         "src/x11_window.c",
         "src/xkb_unicode.c",
         "src/posix_time.c",
         "src/posix_thread.c",
         "src/glx_context.c",
         "src/linux_joystick.c",
         "src/posix_poll.c",
      }

   filter "system:windows"
      systemversion "latest"
      staticruntime "On"
      defines {
         "_GLFW_WIN32",
         "_CRT_SECURE_NO_WARNINGS",
         "UNICODE",
         "_UNICODE",
      }
      files {
         "src/win32_init.c",
         "src/win32_joystick.c",
         "src/win32_monitor.c",
         "src/win32_time.c",
         "src/win32_thread.c",
         "src/win32_window.c",
         "src/wgl_context.c",
      }

   filter "configurations:Debug"
      runtime "Debug"
      symbols "On"

   filter "configurations:Release"
      runtime "Release"
      optimize "On"

-- msbuild GLFW.sln /m /p:Configuration=Release /p:Platform=x64