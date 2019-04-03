#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

tile_left_up()
{
  WinMove ,A ,,0,0,(A_ScreenWidth/2), (A_ScreenHeight/2)
}
tile_left_down()
{
  WinMove ,A,,0,(A_ScreenHeight/2),(A_ScreenWidth/2), (A_ScreenHeight/2)
}
tile_right_up()
{
  WinMove ,A ,,(A_ScreenWidth/2),0,(A_ScreenWidth/2), (A_ScreenHeight/2)
}
tile_right_down()
{
  WinMove ,A,,(A_ScreenWidth/2),(A_ScreenHeight/2),(A_ScreenWidth/2), (A_ScreenHeight/2)
}

AppsKey & Right::Send, #{Right}
AppsKey & Left::Send, #{Left}
AppsKey & Up::Send, #{Up}
AppsKey & Down::Send, #{Down}
;AppsKey & l:: DllCall("LockWorkStation")


AppsKey & f::tile_left_up()
AppsKey & d::tile_left_down()
AppsKey & r::tile_right_up()
AppsKey & e::tile_right_down()


SetKeyDelay 0

is_post_v = 0
is_post_d = 0
is_post_colon = 0
colon_string := ""
is_post_c = 0

reset_is_post()
{
  global is_post_v = 0
  global is_post_d = 0
  global is_post_colon = 0
  global is_post_c = 0
  global colon_string := ""
  return
}

is_target()
{
  if WinActive("gvim")
    return 1
  return 0
}

enter_vi_mode()
{
  reset_is_post()
  ; Set the flags for OSD
  Gui, 99:+AlwaysOnTop -Caption +ToolWindow +Disabled -SysMenu +Owner
  ; Add and set the OSD Text
  Gui, 99:Font, s12 bold
  Gui, 99:Add, Text, cAA0000, VIM-Mode Activated
  ; OSD Background Color (Black)
  Gui, 99:Color, 000000
  Gui, 99:Show,NoActivate xCenter y10, VIM-Mode Activated
  return
}
exit_vi_mode()
{
  reset_is_post()
  Gui, 99:Destroy
  return
}

#IfWinNotExist VIM-Mode Activated
  Capslock::
    if is_target()
;      Send {%A_ThisHotkey%}
      Send {ESC}
    else
      enter_vi_mode()
    return
#IfWinNotExist
#IfWinExist VIM-Mode Activated
  ; exits vi mode
  i::exit_vi_mode()
  +i::
  {
    Send {Home}
    exit_vi_mode()
    return
  }
  o::
  {
    Send {End}{Enter}
    exit_vi_mode() 
    return
  }
  +o::
  {
    Send {Home}{Enter}{Up}
    exit_vi_mode()
    return
  }
  a::
  {
    Send {Right}
    exit_vi_mode()
    return
  }
  +a::
  {
    Send {End}
    exit_vi_mode()
    return
  }

  ; sets is post
  v::
  {
    if is_post_v
      is_post_v = 0
    else
      is_post_v = 1
    return
  }
  :::
  {
    is_post_colon = 1
    return
  }
  d::
  {
    if is_post_d
    {
      Send {Up}{End}
      Send +{Down}
	  Send +{End}^x
      reset_is_post()
    }
    else if is_post_v
    {
      Send ^x
      reset_is_post()
    }
    else
      is_post_d = 1
    return
  }
  c::
  {
    if is_post_c
    {
      Send {Up}{End}
      Send +{Down}
	  Send +{End}^x
      exit_vi_mode()
    }
    else
      is_post_c = 1
    return
  }

  ; arrow keys
  h::
  {
    if is_post_v
      Send +{Left} 
    else
      Send {Left}
    return
  }
  j::
  {
    if is_post_v
      Send +{Down} 
    else
      Send {Down}
    return
  }
  k::
  {
    if is_post_v
      Send +{Up}
    else
      Send {Up}
    return
  }
  l::
  {
    if is_post_v
      Send +{Right} 
    else
      Send {Right}
    return
  }

  ; word movements
  $::
  {
    if is_post_d
    {
      Send +{End}^x
      is_post_d = 0
    }
    else if is_post_v
      Send +{End}
    else
      Send {End}
    return
  }
  0::
  {
    if is_post_d
    {
      Send +{Home}^x
      is_post_d = 0
    }
    else if is_post_v
      Send +{Home}
    else
      Send {Home}
    return
  }
  b::
  {
    if is_post_d
    {
      Send +^{Left}^x
      is_post_d = 0
    }
    else if is_post_v
      Send +^{Left}
    else
      Send ^{Left}
    return
  }
  ^b::
  {
    if is_pos_v
      Send +{PgUp}
    else
      Send {PgUp}
    return
  }
  ^f::
  {
    if is_pos_v
      Send +{PgDn}
    else
      Send {PgDn}
    return
  }
  w::
  {
    if is_post_d
    {
      Send +^{Right}^x
      is_post_d = 0
    }
    else if is_post_v
      Send +^{Right}
    else if is_post_c
    {
      Send +^{Right}^x
      exit_vi_mode()
    }
    else if is_post_colon
    {
      colon_string = % colon_string "w"
    }
    else
      Send ^{Right}
    return
  }
  q::
  {
    if is_post_colon
	  colon_string = % colon_string "q"
    return
  }

  ; Enter key he
  Enter::
  {
    if is_post_colon
    {
      if InStr(colon_string, "w")
        Send ^s
      if InStr(colon_string, "q")
        Send !{F4}
      reset_is_post()
    }
    else
      Send {%A_ThisHotkey%}
    return
  }

  Capslock::reset_is_post()

  x::
  {
    Send {Del}
    is_post_v = 0
    return
  }

  y::
  {
    Send ^c
    is_post_v = 0
    return
  }

  p::
  {
    Send {End}{Enter}
    Send ^v
    is_post_v = 0
    return
  }
  +p::
  {
    Send {Home}{Enter}{Up}
    Send ^v
    is_post_v = 0
    return
  }

  u::
  {
    Send ^z
    return
  }

  +j::
  {
    Send {End}{Del}
    Return
  }
#IfWinExist
