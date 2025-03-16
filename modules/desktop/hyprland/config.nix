{
  config,
  pkgs,
}: let
  cursorCfg = config.home-manager.users.${config.user.name}.home.pointerCursor;
  inherit (config.colorScheme) palette;

  terminalCmd = "alacritty";
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

    layerrule=blur,anyrun
    layerrule=ignorezero,anyrun
    layerrule=blur,eww-bar
    layerrule=ignorezero,eww-bar

    ${
      if (config.networking.hostName == "helium")
      then ''workspace=6,monitor:HDMI-A-2,default:true
             monitor=HDMI-A-2,preferred,-1920x0,1''
      else "monitor=HDMI-A-1,preferred,auto,1,mirror,eDP-1"
    }

    input {
      repeat_rate=50
      repeat_delay=225

      follow_mouse=true
    }

    general {
      gaps_in=0
      gaps_out=0
      border_size=2

      col.active_border=rgb(${palette.fg})
      col.inactive_border=rgb(${palette.bg})

      layout=${layout}
      resize_on_border=true
      hover_icon_on_border=false
    }

    decoration {
      rounding=0

      blur {
        enabled=true
        size=3
        passes=4
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
    bind=SUPER,X,exec,wlogout -p layer-shell
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

    # Volume keys.
    bind=,XF86AudioMute,exec,pactl set-sink-mute @DEFAULT_SINK@ toggle
    binde=,XF86AudioLowerVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ -2%
    binde=,XF86AudioRaiseVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ +2%
    bind=,XF86AudioMicMute,exec,pactl set-source-mute @DEFAULT_SOURCE@ toggle

    # Player controls.
    bind=,XF86AudioPlay,exec,playerctl play-pause
    bind=,XF86AudioStop,exec,playerctl stop
    bind=,XF86AudioNext,exec,playerctl next
    bind=,XF86AudioPrev,exec,playerctl previous

    # Screen backlight.
    bind=,XF86MonBrightnessUp,exec,brightnessctl set 2%+
    bind=,XF86MonBrightnessDown,exec,brightnessctl set 2%-

    # Reload configuration.
    bind=SUPER,C,exec,hyprctl reload

    # Start some applications in the background.
    exec-once=dbus-update-activation-environment --systemd --all
    exec-once=hyprpaper
    exec-once=hyprsunset
    exec-once=eww open bar --screen 0 --id primary
    exec-once=fcitx5
    exec-once=swaync
  '';
}
