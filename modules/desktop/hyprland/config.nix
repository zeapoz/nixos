{
  config,
  pkgs,
  blur_size,
  blur_passes,
}: let
  cursorCfg = config.home-manager.users.${config.user.name}.home.pointerCursor;
  inherit (config.colorScheme) palette;

  terminalCmd = "wezterm";
  browser = "zen";
  musicApp = "spotify";
  layout = "master";
in {
  hyprlandConfig = ''
    monitor=,preferred,auto,1

    # Set mouse cursor.
    exec-once=hyprctl setcursor ${cursorCfg.name} ${
      builtins.toString cursorCfg.size
    }

    # Start in locked mode.
    exec-once=hyprlock

    # Never lock on fullscreen.
    windowrulev2 = idleinhibit fullscreen, class:.*

    layerrule=blur,swaync-notification-window
    layerrule=ignorezero,swaync-notification-window
    layerrule=blur,swaync-control-center
    layerrule=ignorezero,swaync-control-center
    layerrule=blur,anyrun
    layerrule=ignorezero,anyrun
    layerrule=blur,eww-bar
    layerrule=ignorezero,eww-bar
    layerrule=blur,logout_dialog
    layerrule=ignorezero,logout_dialog
    ${
      if (config.networking.hostName == "helium")
      then ''        workspace=6,monitor:HDMI-A-2,default:true
                     monitor=HDMI-A-2,preferred,-1920x0,1''
      else "monitor=HDMI-A-1,preferred,auto,1,mirror,eDP-1"
    }

    input {
      repeat_rate=50
      repeat_delay=225

      follow_mouse=true
    }

    general {
      gaps_in=4
      gaps_out=6
      border_size=2

      col.active_border=rgb(${palette.fg})
      col.inactive_border=rgb(${palette.bg})

      layout=${layout}
      resize_on_border=true
      hover_icon_on_border=false
    }

    decoration {
      rounding=10

      blur {
        enabled=true
        size=${builtins.toString blur_size}
        passes=${builtins.toString blur_passes}
        popups=true
        input_methods=true
      }

      shadow {
        ignore_window=true
        offset=2 2
        range=15
        render_power=2
      }
    }

    animations {
      enabled=true

      animation=windows,1,1,default,popin 95%
      animation=border,1,1,default
      animation=fade,0,1,default
      animation=workspaces,1,1,default,slidevert
    }

    group {
      col.border_active=rgb(${palette.fg})
      col.border_inactive=rgb(${palette.bg})
    }

    misc {
      disable_hyprland_logo=true
      disable_splash_rendering=true
    }

    binds {
      workspace_back_and_forth=true
    }

    ${
      if (layout == "dwindle")
      then ''
        dwindle {
          preserve_split=true
        }

        bind=SUPER,m,movefocus,l
        bind=SUPER,n,movefocus,d
        bind=SUPER,e,movefocus,u
        bind=SUPER,i,movefocus,r

        bind=SUPERSHIFT,m,movewindow,l
        bind=SUPERSHIFT,n,movewindow,d
        bind=SUPERSHIFT,e,movewindow,u
        bind=SUPERSHIFT,i,movewindow,r

        # Resize submap.
        bind=SUPER,R,submap,resize
        submap=resize

        binde=,m,resizeactive,-100 0
        binde=,n,resizeactive,0 100
        binde=,e,resizeactive,0 -100
        binde=,i,resizeactive,100 0

        bind=,escape,submap,reset
        bind=,RETURN,submap,reset
        bind=SUPER,R,submap,reset
        submap=reset
      ''
      else if (layout == "master")
      then ''
        master {
          allow_small_split=true
          mfact=0.7
          new_on_top=true
          orientation=right
        }

        bind=SUPER,n,layoutmsg,cyclenext
        bind=SUPER,e,layoutmsg,cycleprev

        bind=SUPER,m,resizeactive,-100 0
        bind=SUPER,i,resizeactive,100 0

        # Resize submap.
        bind=SUPER,R,submap,resize
        submap=resize

        binde=,m,resizeactive,-100 0
        binde=,n,resizeactive,0 100
        binde=,e,resizeactive,0 -100
        binde=,i,resizeactive,100 0

        binde=,left,moveactive,-100 0
        binde=,down,moveactive,0 100
        binde=,up,moveactive,0 -100
        binde=,right,moveactive,100 0

        bind=,escape,submap,reset
        bind=,RETURN,submap,reset
        bind=SUPER,R,submap,reset
        submap=reset

        bind=SUPERSHIFT,m,layoutmsg,addmaster
        bind=SUPERSHIFT,i,layoutmsg,removemaster

        bind=SUPERSHIFT,n,layoutmsg,swapnext
        bind=SUPERSHIFT,e,layoutmsg,swapprev
        bind=SUPERSHIFT,RETURN,layoutmsg,swapwithmaster

        bind=SUPER,left,layoutmsg,orientationleft
        bind=SUPER,right,layoutmsg,orientationright
        bind=SUPER,down,layoutmsg,orientationbottom
        bind=SUPER,up,layoutmsg,orientationtop
      ''
      else ""
    }

    # some nice mouse binds
    bindm=SUPER,mouse:272,movewindow
    bindm=SUPER,mouse:273,resizewindow

    # Useful applications.
    bind=SUPER,RETURN,exec,${terminalCmd}
    bind=SUPER,D,exec,anyrun
    bind=SUPER,B,exec,${browser}
    bind=SUPER,P,exec,${terminalCmd} -e fish -c yazi
    bind=SUPER,S,exec,${musicApp}

    # Notification center.
    bind=SUPER,H,exec,swaync-client --toggle-panel

    bind=SUPER,W,killactive,
    bind=SUPERSHIFT,Q,exit,

    bind=SUPER,F,fullscreen,0
    bind=SUPER,SPACE,togglefloating,

    # Monitors.
    bind=SUPER,COMMA,focusmonitor,l
    bind=SUPER,PERIOD,focusmonitor,r

    bind=ALT,COMMA,movewindow,mon:l
    bind=ALT,PERIOD,movewindow,mon:r

    bind=ALTSHIFT,COMMA,movecurrentworkspacetomonitor,l
    bind=ALTSHIFT,PERIOD,movecurrentworkspacetomonitor,r

    # Workspaces.
    bind=SUPER,l,workspace,1
    bind=SUPER,u,workspace,2
    bind=SUPER,y,workspace,3
    bind=SUPER,semicolon,workspace,4
    bind=SUPER,bracketleft,workspace,5
    bind=SUPER,bracketright,workspace,6

    bind=ALT,l,movetoworkspace,1
    bind=ALT,u,movetoworkspace,2
    bind=ALT,y,movetoworkspace,3
    bind=ALT,semicolon,movetoworkspace,4
    bind=ALT,bracketleft,movetoworkspace,5
    bind=ALT,bracketright,movetoworkspace,6

    bind=ALTSHIFT,l,movetoworkspacesilent,1
    bind=ALTSHIFT,u,movetoworkspacesilent,2
    bind=ALTSHIFT,y,movetoworkspacesilent,3
    bind=ALTSHIFT,semicolon,movetoworkspacesilent,4
    bind=ALTSHIFT,bracketleft,movetoworkspacesilent,5
    bind=ALTSHIFT,bracketright,movetoworkspacesilent,6

    bind=SUPER,mouse_down,workspace,e+1
    bind=SUPER,mouse_up,workspace,e-1

    # Groups submap.
    bind=SUPER,SLASH,submap,group
    submap=group

    binde=,t,togglegroup
    binde=,l,lockactivegroup,toggle

    binde=,m,moveintogroup,l
    binde=,n,moveintogroup,d
    binde=,e,moveintogroup,u
    binde=,i,moveintogroup,r

    binde=SHIFT,m,moveoutofgroup

    bind=,escape,submap,reset
    bind=,RETURN,submap,reset
    bind=SUPER,SLASH,submap,reset
    submap=reset

    bind=,Caps_Lock,exec,sleep 0.05; swayosd-client --caps-lock

    # Volume keys.
    bindl=,XF86AudioMute,exec,swayosd-client --output-volume mute-toggle
    bindle=,XF86AudioLowerVolume,exec,swayosd-client --output-volume lower
    bindle=,XF86AudioRaiseVolume,exec,swayosd-client --output-volume raise
    bindl=,XF86AudioMicMute,exec,swayosd-client --input-volume mute-toggle

    # Screen backlight.
    bindl=,XF86MonBrightnessUp,exec,swayosd-client --brightness raise
    bindl=,XF86MonBrightnessDown,exec,swayosd-client --brightness lower

    # Player controls.
    bindl=,XF86AudioPlay,exec,playerctl play-pause
    bindl=,XF86AudioStop,exec,playerctl stop
    bindl=,XF86AudioNext,exec,playerctl next
    bindl=,XF86AudioPrev,exec,playerctl previous

    # Reload configuration.
    bind=SUPER,C,exec,hyprctl reload

    # Start some applications in the background.
    exec-once=dbus-update-activation-environment --systemd --all
    exec-once=hyprpaper
    exec-once=hyprsunset
    exec-once=hypridle
    exec-once=fcitx5
    exec-once=swayosd-server
    exec-once=swaync
    exec-once=eww open bar --screen 0 --id primary
  '';
}
