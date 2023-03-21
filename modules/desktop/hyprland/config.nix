{ config, lib, pkgs }:
let
  cursorCfg = config.home-manager.users.${config.user.name}.home.pointerCursor;
  colors = config.colorScheme.colors;

  layout = "master";
in
{
  hyprlandConfig = ''
    monitor=,preferred,auto,1

    # https://wiki.hyprland.org/FAQ/#some-of-my-apps-take-a-really-long-time-to-open
    exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec-once=systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

    # Set mouse cursor.
    exec-once=hyprctl setcursor ${cursorCfg.name} ${
      builtins.toString cursorCfg.size
    }

    blurls=waybar
    blurls=wofi

    input {
      kb_layout=us,se
      ${
        if (config.networking.hostName == "neon") then
          "kb_options=grp:shift_toggle,caps:swapescape"
        else
          "kb_options=grp:shift_toggle"
      }

      repeat_rate=50
      repeat_delay=225

      follow_mouse=1
    }

    general {
      gaps_in=5
      gaps_out=10
      border_size=3

      col.active_border=rgb(${colors.fg})
      col.inactive_border=rgba(${colors.bg}E6)
      col.group_border_active=rgb(${colors.fg})
      col.group_border=rgb(${colors.bg})

      layout=${layout}
      resize_on_border=true
      hover_icon_on_border=false
    }

    decoration {
      # rounding=10

      blur=true
      blur_size=3
      blur_new_optimizations=1

      shadow_range=15
      shadow_render_power=2
    }

    animations {
      enabled=1
      animation=windows,1,2,default
      animation=windows,1,2,default,popin 80%
      animation=border,1,3,default
      animation=fade,1,2,default
      animation=workspaces,1,2,default,fade
    }

    misc {
      disable_hyprland_logo=true
      disable_splash_rendering=true
    }

    binds {
      workspace_back_and_forth=true
    }

    ${if (layout == "dwindle") then ''
      dwindle {
        preserve_split=true
      }

      bind=SUPER,H,movefocus,l
      bind=SUPER,J,movefocus,d
      bind=SUPER,K,movefocus,u
      bind=SUPER,L,movefocus,r

      bind=SUPERSHIFT,H,movewindow,l
      bind=SUPERSHIFT,J,movewindow,d
      bind=SUPERSHIFT,K,movewindow,u
      bind=SUPERSHIFT,L,movewindow,r

      # Resize submap.
      bind=SUPER,R,submap,resize
      submap=resize

      binde=,h,resizeactive,-100 0
      binde=,j,resizeactive,0 100
      binde=,k,resizeactive,0 -100
      binde=,l,resizeactive,100 0

      bind=,escape,submap,reset
      bind=,RETURN,submap,reset
      bind=SUPER,R,submap,reset
      submap=reset'' else
      ""}

    ${if (layout == "master") then ''
      master {
        new_is_master=false
        new_on_top=true
      }

      bind=SUPER,J,layoutmsg,cyclenext
      bind=SUPER,K,layoutmsg,cycleprev

      bind=SUPER,h,resizeactive,-100 0
      bind=SUPER,l,resizeactive,100 0
      bind=SUPERSHIFT,l,layoutmsg,removemaster
      bind=SUPERSHIFT,h,layoutmsg,addmaster

      bind=SUPERSHIFT,J,layoutmsg,swapnext
      bind=SUPERSHIFT,K,layoutmsg,swapprev
      bind=SUPERSHIFT,RETURN,layoutmsg,swapwithmaster

      bind=SUPER,left,layoutmsg,orientationleft
      bind=SUPER,right,layoutmsg,orientationright
      bind=SUPER,down,layoutmsg,orientationbottom
      bind=SUPER,up,layoutmsg,orientationtop'' else
      ""}

    # some nice mouse binds
    bindm=SUPER,mouse:272,movewindow
    bindm=SUPER,mouse:273,resizewindow

    # Useful applications.
    bind=SUPER,RETURN,exec,kitty
    bind=SUPER,D,exec,wofi --show drun -I
    bind=SUPER,X,exec,wlogout
    bind=SUPER,N,exec,${config.modules.editors.mainEditor}
    bind=SUPER,B,exec,firefox
    bind=SUPER,E,exec,thunar
    bind=SUPER,S,exec,spotify
    bind=SUPER,Y,exec,freetube

    # Second layer.
    bind=SUPERSHIFT,B,exec,brave
    bind=SUPERSHIFT,Q,exec,kitty hx ~/.config/NixOS

    bind=SUPER,W,killactive,
    bind=SUPERSHIFT,E,exit,

    bind=SUPER,F,fullscreen,0
    bind=SUPER,SPACE,togglefloating,

    # Monitors.
    bind=SUPER,COMMA,focusmonitor,l
    bind=SUPER,PERIOD,focusmonitor,r

    bind=ALT,COMMA,movewindow,mon:l
    bind=ALT,PERIOD,movewindow,mon:r

    bind=ALTSHIFT,COMMA,movecurrentworkspacetomonitor,l
    bind=ALTSHIFT,PERIOD,movecurrentworkspacetomonitor,r

    # Groups.
    bind=SUPER,SLASH,togglegroup
    bind=SUPER,PERIOD,lockgroups,lock
    bind=SUPERSHIFT,PERIOD,lockgroups,unlock
    bind=SUPER,SEMICOLON,changegroupactive,b
    bind=SUPER,APOSTROPHE,changegroupactive,f

    # Workspaces.
    bind=SUPER,u,workspace,1
    bind=SUPER,i,workspace,2
    bind=SUPER,o,workspace,3
    bind=SUPER,p,workspace,4

    bind=ALT,u,movetoworkspace,1
    bind=ALT,i,movetoworkspace,2
    bind=ALT,o,movetoworkspace,3
    bind=ALT,p,movetoworkspace,4

    bind=ALTSHIFT,u,movetoworkspacesilent,1
    bind=ALTSHIFT,i,movetoworkspacesilent,2
    bind=ALTSHIFT,o,movetoworkspacesilent,3
    bind=ALTSHIFT,p,movetoworkspacesilent,4

    bind=SUPER,mouse_down,workspace,e+1
    bind=SUPER,mouse_up,workspace,e-1

    # Volume keys.
    bind=,XF86AudioMute,exec,pactl set-sink-mute @DEFAULT_SINK@ toggle
    bind=,XF86AudioLowerVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ -5%
    bind=,XF86AudioRaiseVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ +5%
    bind=,XF86AudioMicMute,exec,pactl set-source-mute @DEFAULT_SOURCE@ toggle

    # Player controls.
    bind=,XF86AudioPlay,exec,playerctl play-pause
    bind=,XF86AudioStop,exec,playerctl stop
    bind=,XF86AudioNext,exec,playerctl next
    bind=,XF86AudioPrev,exec,playerctl previous

    # Screen backlight.
    bind=,XF86MonBrightnessUp,exec,brightnessctl set 5%+
    bind=,XF86MonBrightnessDown,exec,brightnessctl set 5%-

    # Reload configuration.
    bind=SUPER,C,exec,hyprctl reload
    bind=SUPERSHIFT,C,exec,killall -SIGUSR2 .waybar-wrapped

    # Change background.
    bind=SUPERSHIFT,N,exec,killall -q swaybg -9; swaybg -i "$(find ~/Pictures/Wallpapers -type f | shuf -n 1)" -m fill

    # Start some applications in the background.
    exec-once=~/.config/hypr/autostart.sh
  '';

  autostart = ''
    waybar &
    swaybg -i $(find ~/Pictures/Wallpapers -type f | shuf -n 1) -m fill &
    mullvad-gui &
  '';

  wrappedhl = pkgs.writeShellScriptBin "wrappedhl" ''
    #!/bin/sh

    cd ~

    # Log WLR errors and logs to the hyprland log. Recommended
    export HYPRLAND_LOG_WLR=1

    # Tell XWayland to use a cursor theme
    export XCURSOR_THEME=${cursorCfg.name}

    # Set a cursor size
    export XCURSOR_SIZE=${builtins.toString cursorCfg.size}

    exec Hyprland
  '';
}
