# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'


    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls -alh'
alias dirs='dirs -v'
alias mutt='neomutt'
alias  lsblk='lsblk -e7'
alias rn='ranger'
#alias python='python3'
# This chagnes the look of the bash command line.
export PS1="___________________    | \w @ \h (\u) \n| => "
export PS2="| => "
# My custom alias for bash
alias vim='nvim'
alias vi='/usr/bin/vim'
alias pud='pushd'
alias pop='popd'
alias basevpn='sudo openconnect --certificate "$HOME/.cert/adca-$USER.crt" --sslkey "$HOME/.cert/adca-$USER.key" bastion-vpn.osl.basefarm.net'
alias linbast8='ssh bf-linbast08.osl.basefarm.net'
alias xlinbast8='ssh -X -C bf-linbast08.osl.basefarm.net xterm'
alias xamsbast8='ssh -X -C bf-linbast08.ams.basefarm.net xterm'
alias bftake='sftp bf-linbast08.osl.basefarm.net'
alias localpfbind='ssh -L 9000:localhost:8443 -p 1000 habbis@larsen.habbis.trade'
alias copy="xclip -sel c <"
alias df='df -x"squashfs"'

#Den første er for winbast, typ `remote 14` for winbast14 osv

remote () {
    if [ -z "$2" ]
    then
        rdesktop bf-winbast"$1".mgmt.basefarm.net -g 1920x1020 -k no -r clipboard:CLIPBOARD -r disk:ebbestad=/home/$(whoami)/winbast
    else
        rdesktop bf-winbast"$1".mgmt.basefarm.net -g 2560x1400 -k no -r clipboard:CLIPBOARD -r disk:ebbestad=/home/$(whoami)/winbast
    fi
}


#vi () (
#
#
#
#)
#


#Den andre er for linbast som funker for alle tre landene, typ `bastion-ssh 08` for norsk linbast, `bastion-ssh 08 sth` for Sverige og `bastion-ssh 08 ams` for Nederland

bastion-ssh () {
    if [ -z "$1" ]
    then
        printf "Usage bastion-ssh [sth/ams]\n osl is default\n"
        return 1
    elif [ -z "$2" ]
    then
        ssh bf-linbast"$1".osl.basefarm.net
    else
        ssh bf-linbast"$1"."$2".basefarm.net
    fi
}


bfcp ()  {
 
python3 /opt/basefarm/BFY/bfy_clipboard.py 

}

shot () {
scrot -s '/tmp/%F_%T_$wx$h.png' -e 'xclip -selection clipboard -target image/png -i $f ; rm $f'
}

addssh () {

  eval `ssh-agent  -s`
  ssh-agent bash 
  ssh-add -s /usr/lib/x86_64-linux-gnu/opensc-pkcs11.so 


}

#########
# Docker#
#########
chrome () {
docker run -it  --cpuset-cpus 2 --memory 2100mb  -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -v $HOME/Downloads:/home/chrome/Downloads -v $HOME/.config/google-chrome/:/data --security-opt seccomp=$HOME/chrome.json --device /dev/snd --device /dev/dri -v /dev/shm:/dev/shm   --name chrome chrome:mk1

}

vscode () {
 docker run -d \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME:/home/user \
    -e DISPLAY=unix$DISPLAY \
    --device /dev/dri \
    --name vscode \
    vscode:mk1 


}


atom () {
docker run -v /tmp/.X11-unix:/tmp/.X11-unix \
              -v $HOME:/home/user \
             -e DISPLAY=unix$DISPLAY atom:mk1 


}


sub3 () {
 docker run -d -it \
       -w $HOME/Documents \
       -v $HOME/.config/sublime-text-3:$HOME/.config/sublime-text-3 \
       -v $HOME/Documents:$HOME/Documents \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
      -v $HOME/.local/share/recently-used.xbel:$HOME/.local/share/recently-used.xbel \
      -e DISPLAY=$DISPLAY \
     -e NEWUSER=$USER \
     -e LANG=en_US.UTF-8 \
     sub3:mk1 


}


typora () {
 docker run -d \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME:/home/user \
    -e DISPLAY=unix$DISPLAY \
    --device /dev/dri \
    --name typora  \
    typora:mk1 


}


#########
# Utillity #
#########

mkp () {
echo "Ansible playbook name"
read  name
mkdir -p ${name}
mkdir -p group_vars
echo "Name of the role"
read rolename 
mkdir -p ${name}/roles/${rolename}/handlers/
mkdir -p ${name}/roles/${rolename}/task/
mkdir -p ${name}/roles/${rolename}/templates/
touch ${name}/hosts
touch ${name}/site.yml
touch ${name}/roles/${rolename}/handlers/main.yml
touch ${name}/roles/${rolename}/task/main.yml
}

# Download  ubuntu cloud images for kvm

bionic () {
  echo "The image name for the new image"
 read image

 if [ ! -f bionic-server-cloudimg-amd64.img ]; then
        #echo "Choose distro type name link disco 19.04 bionic 18.04 xenial 16.04 trusty 14.04"
         distro="bionic"
        wget https://cloud-images.ubuntu.com/${distro}/current/${distro}-server-cloudimg-amd64.img
        wget https://cloud-images.ubuntu.com/${distro}/current/SHA256SUMS
elif [ -f bionic-server-cloudimg-amd64.img ]; then
        cp bionic-server-cloudimg-amd64.img ${image}.img

else
	echo "Something is wrong"
 fi

 sha256sum -c SHA256SUMS | sort | egrep bionic.server.cloudimg.amd64.img:

 if [ -f cloud-config.yaml ]; then
      cloud-localds config.iso cloud-config.yaml
fi 

 echo "File size for the image user big G and write a numbe like 25G"
 read size
 if [  -f ${image}.img ]; then
       qemu-img convert -O qcow2  ${image}.img ${image}.qcow2
       qemu-img resize ${image}.qcow2 ${size}
 elif [ -f bionic-server-cloudimg-amd64.img  ]; then
        cp bionic-server-cloudimg-amd64.img ${image}.img
	#sleep 1
        qemu-img convert -O qcow2  ${image}.img ${image}.qcow2
        qemu-img resize ${image}.qcow2 ${size}
 else 
     echo "something wrong" 
 fi

 if [ -f ${image}.img ]; then
 rm -rf *.img
 fi 
}



xenial () {
  echo "The image name for the new image"
 read image

 if [ ! -f xenial-server-cloudimg-amd64.img ]; then
        #echo "Choose distro type name link disco 19.04 bionic 18.04 xenial 16.04 trusty 14.04"
         distro="xenial"
        wget https://cloud-images.ubuntu.com/${distro}/current/${distro}-server-cloudimg-amd64.img
        wget https://cloud-images.ubuntu.com/${distro}/current/SHA256SUMS
elif [ -f bionic-server-cloudimg-amd64.img ]; then
        cp bionic-server-cloudimg-amd64.img ${image}.img

else
	echo "Something is wrong"
 fi

 sha256sum -c SHA256SUMS | sort | egrep bionic.server.cloudimg.amd64.img:

 if [ -f cloud-config.yaml ]; then
      cloud-localds config.iso cloud-config.yaml
fi 

 echo "File size for the image user big G and write a numbe like 25G"
 read size
 if [  -f ${image}.img ]; then
       qemu-img convert -O qcow2  ${image}.img ${image}.qcow2
       qemu-img resize ${image}.qcow2 ${size}
 elif [ -f bionic-server-cloudimg-amd64.img  ]; then
        cp bionic-server-cloudimg-amd64.img ${image}.img
	#sleep 1
        qemu-img convert -O qcow2  ${image}.img ${image}.qcow2
 else 
     echo "something wrong" 
 fi

 if [ -f ${image}.img ]; then
 rm -rf *.img
 fi 
}


trusty () {
  echo "The image name for the new image"
 read image

 if [ ! -f trusty-server-cloudimg-amd64.img ]; then
        #echo "Choose distro type name link disco 19.04 bionic 18.04 xenial 16.04 trusty 14.04"
         distro="trusty"
        wget https://cloud-images.ubuntu.com/${distro}/current/${distro}-server-cloudimg-amd64.img
        wget https://cloud-images.ubuntu.com/${distro}/current/SHA256SUMS
elif [ -f bionic-server-cloudimg-amd64.img ]; then
        cp bionic-server-cloudimg-amd64.img ${image}.img

else
	echo "Something is wrong"
 fi

 sha256sum -c SHA256SUMS | sort | egrep bionic.server.cloudimg.amd64.img:

 if [ -f cloud-config.yaml ]; then
      cloud-localds config.iso cloud-config.yaml
fi 

 echo "File size for the image user big G and write a numbe like 25G"
 read size
 if [  -f ${image}.img ]; then
       qemu-img convert -O qcow2  ${image}.img ${image}.qcow2
       qemu-img resize ${image}.qcow2 ${size}
 elif [ -f bionic-server-cloudimg-amd64.img  ]; then
        cp bionic-server-cloudimg-amd64.img ${image}.img
	#sleep 1
        qemu-img convert -O qcow2  ${image}.img ${image}.qcow2
	qemu-img resize ${image}.qcow2 ${size}

 else 
     echo "something wrong" 
 fi

 if [ -f ${image}.img ]; then
 rm -rf *.img
 fi 
}


centos7 () {
  echo "The image name for the new image"
 read image

 if [ ! -f CentOS-7-x86_64-GenericCloud-1907.qcow2 ]; then
        #echo "Choose distro type name link disco 19.04 bionic 18.04 xenial 16.04 trusty 14.04"
        wget http://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-1907.qcow2.xz
        wget http://cloud.centos.org/centos/7/images/sha256sum.txt 
sleep 1
 elif [  -f CentOS-7-x86_64-GenericCloud-1907.qcow2.xz ]; then
	 xz -d  CentOS-7-x86_64-GenericCloud-1907.qcow2.xz

 elif [  -f CentOS-7-x86_64-GenericCloud-1907.qcow2 ]; then
        cp CentOS-7-x86_64-GenericCloud-1907.qcow2 ${image}.qcow2
else
	echo "Something is wrong with Download or tar"
 fi


 sha256sum -c sha256sum.txt | sort | egrep CentOS-7-x86_64-GenericCloud-1907.qcow2.xz

 if [ -f cloud-config.yaml ]; then
      cloud-localds config.iso cloud-config.yaml
fi 

 echo "File size for the image user big G and write a numbe like 25G"
 read size
 if [ -f ${image}.qcow2 ]; then
       qemu-img convert -O qcow2  ${image}.img ${image}.qcow2
       qemu-img resize ${image}.qcow2 ${size}
 fi
 # elif [ -f ${image}.qcow2  ]; then
        # cp  CentOS-7-x86_64-GenericCloud-1907.qcow2 ${image}.img
        # qemu-img convert -O qcow2  ${image}.img ${image}.qcow2
        # qemu-img resize ${image}.qcow2 ${size}
 # else 
     # echo "something wrong with image resize or convert" 


 if [ -f sha256sum.txt]; then
      rm -rf sha256*
 fi 

 if [ -f ${image}.img ]; then
 rm -rf CentOS-7-x86_64-GenericCloud-1907.*
 fi 
}

## cd to the virtual machine dir and run the command.

virt () {

echo "Name of the virtual machine"
read virtname

echo "os variant, example ubuntu18.04, centos7.0, debian9,"

echo "size of ram"
read ram

echo "amount of cpu"
read cpu


diskimage=$(ls -al | grep *.qcow2 | awk '{print $9}')
location=$(pwd)
cloud-config=$(ls -al | grep *.iso | awk '{print $9}')

virt-install \
  --memory ${cpu} \
  --vcpus ${cpu} \
  --name ${virtname} \
  --disk ${location}/${diskimage},device=disk \
  --disk ${location}/${cloud-config},device=cdrom \
  --os-type Linux \
  --os-variant ${os} \
  --virt-type kvm \
  --graphics none \
  --network default \
  --import
}

#copy () {
#
#if [ -z "$1" ] 
#then
    #printf "Usage pipe with < to copy to copy txt to clipboard\n"
    #return 1
    #elif [ -z "$2" ]
    #then 
       #xclip -sel < "$2"
    #else echo "no arguments"
    #fi 
#
#}
# makes it better for adding yubikey to ssh agent
# to add yubikey to ssh-agen use 'ssh-add -s $OPENSC' then type the PIN then type the PIN 
OPENSC="/usr/lib/x86_64-linux-gnu/opensc-pkcs11.so"
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
#You also don't need to enter the PIN all the time, since ssh-agent supports PKCS11 as well. Run 
# use this command when you have problems with ssh-add -s eval `ssh-agent  -s`

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

# This command start tmux or screen and check if screen or tmux is running 
#if command -v tmux>/dev/null; then
#	[[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
#fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# added by Anaconda3 installer
export PATH="/home/habbis/anaconda3/bin:$PATH"

set editor=vim

export VISUAL=vim
export EDITOR="$VISUAL"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
