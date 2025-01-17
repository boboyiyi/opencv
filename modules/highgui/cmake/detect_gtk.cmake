# --- GTK ---
ocv_clear_vars(HAVE_GTK HAVE_GTK3 HAVE_GTHREAD HAVE_GTKGLEXT)
if(WITH_GTK AND NOT HAVE_QT)
  if(NOT WITH_GTK_2_X)
    ocv_check_modules(GTK3 gtk+-3.0)
    if(HAVE_GTK3)
      ocv_add_external_target(gtk3 "${GTK3_INCLUDE_DIRS}" "${GTK3_LIBRARIES}" "HAVE_GTK3;HAVE_GTK")
      set(HAVE_GTK TRUE)
      set(GTK3_VERSION "${GTK3_VERSION}" PARENT_SCOPE) # informational
    endif()
  endif()
  if(TRUE)
    ocv_check_modules(GTK2 gtk+-2.0)
    if(HAVE_GTK2)
      set(MIN_VER_GTK "2.18.0")
      if(GTK2_VERSION VERSION_LESS MIN_VER_GTK)
        message(FATAL_ERROR "GTK support requires a minimum version of ${MIN_VER_GTK} (${GTK2_VERSION} found)")
      else()
        ocv_add_external_target(gtk2 "${GTK2_INCLUDE_DIRS}" "${GTK2_LIBRARIES}" "HAVE_GTK2;HAVE_GTK")
        set(HAVE_GTK TRUE)
        set(GTK2_VERSION "${GTK2_VERSION}" PARENT_SCOPE) # informational
      endif()
    endif()
  endif()
  ocv_check_modules(GTHREAD gthread-2.0)
  if(HAVE_GTK AND NOT HAVE_GTHREAD)
    message(FATAL_ERROR "gthread not found. This library is required when building with GTK support")
  else()
    ocv_add_external_target(gthread "${GTHREAD_INCLUDE_DIRS}" "${GTHREAD_LIBRARIES}" "HAVE_GTHREAD")
    set(HAVE_GTHREAD "${HAVE_GTHREAD}" PARENT_SCOPE) # informational
    set(GTHREAD_VERSION "${GTHREAD_VERSION}" PARENT_SCOPE) # informational
  endif()
  if(WITH_OPENGL AND NOT HAVE_GTK3)
    ocv_check_modules(GTKGLEXT gtkglext-1.0)
    if(HAVE_GTKGLEXT)
      ocv_add_external_target(gtkglext "${GTKGLEXT_INCLUDE_DIRS}" "${GTKGLEXT_LIBRARIES}" "HAVE_GTKGLEXT")
      set(HAVE_GTKGLEXT "${HAVE_GTKGLEXT}" PARENT_SCOPE) # informational
      set(GTKGLEXT_VERSION "${GTKGLEXT_VERSION}" PARENT_SCOPE) # informational
    endif()
  endif()
endif()

set(HAVE_GTK ${HAVE_GTK} PARENT_SCOPE)
set(HAVE_GTK3 ${HAVE_GTK3} PARENT_SCOPE)
