# Today I Learned
_Technical snippets and sizzle_

# `man` First Search

- `man -k` is the same as `apropos`
- `man -K` is the same as `whatis`
- `apropos <str>` lists all man summaries (name + one-line description) of commands that
  mention `<str>`
- `whatis <cmd>` is like `man <cmd> | grep -A 1 NAME | tail -1` (show just the NAME section)

Summary: `apropos` seems handy.


# (DRAFT) Recent History Time Travel with Git
_5.6.2020_
Something I did in the last half an hour just broke a bunch of styles in my elm front-end. I'm using
[`elm-ui`](https://github.com/mdgriffith/elm-ui/), which has been lovely, but I don't understand
the way it implements styles well enough to diganose and solve the problem in a jiffy;
it's late, and all I want to do is make a little more progress on some features before
turning in to read my book.

All I want to do is rewind my changes a few times until it starts working again, and
then diff against my current head.

Except I've been writing code for hours w/o commiting.


# The One Thing You Don't Understand About Tmux Environment Variables
_5.6.2020_

_tl;dr tmux sessions inherit their environment from the tmux server, not from the process
calling `tmux new-session`. And because starting a new session w/o an existing server will
create your tmux server in the same process, your 2nd-Nth tmux sessions will appear to
inherit their environment from the first session&mdash;again, not from the process calling
`tmux new-session`. You can selectively apply

I vent as only a jilted lover can.

_target audience: TODO_

## Prelude: A Command Line Love Story

I've been on speaking terms with tmux for more than a decade, and sleeping over for more
than six or seven. I have a change-directory hook in my [fish
config](https://github.com/cameron/dotfiles/blob/master/.config/fish.symlink/config.fish#L8)
that checks the new directory for a `.tmux` script and attempts to attach to a tmux session
by the name of the directory, creating a new one (by running said `.tmux`) if one does not
already exist.

It's a simple way to define my development process and environment on a per-project basis
that makes re/starting the entire thing nearly instantaneous, and lets me focus on
features instead of spinning plates.

So&mdash;I think tmux is great, but holy guacamole is its enviroment variable handling
confounding&mdash;at first.

## Environmental Expectations

If you've spent a little time in unix shells, you'll know about environment variables; each
running process has a set of them, and when one process creates another (a child process), the
child process is said to inherit a copy of its parent's enviroment; this is often used to
configure a child process when more complicated IPC (interprocess communication) via
sockets or pipes or network protocols are unnecessary.

So, until today, my assumption was that when I created a new `tmux` session, each window's
process would inherit the environment of the shell from which I created the session. And
that seemed to be the case&mdash;but only for the first session! Subsequent sessions (in my
case, tmux sessions started to work on different projects) would inherit the environment of
the first!

And this is a problem for me; I rely on the environment variable `TMUX_PROJECT` (as set by
the aforementioned change-directory hook) in some of my project scripts to, e.g., find and
kill orphaned workflow scripts (my use of `parallel` and `tmux` often results in orphans
after window reloads and session restarts,
so `ps e | grep  parallel.*TMUX_PROJECT=$TMUX_PROJECT | grep -v grep | xargs kill` is an
easy way to kill all `parallel` processes run from the current project).

## Tmux's Client-Server Architecture

This is not, as it happens, a bug, but a consequence (I won't call it a feature, because
it's not worth advertising) of tmux's client-server implementation. Briefly, a `tmux` server has
many sessions, and a session can have many clients. From the command line, you rarely
reference servers, but mostly sessions. `tmux` handles starting and stopping the server
when the first and last session are created and destroyed.

Knowing this, it starts to make sense why my 2nd-Nth project sessions had environments
reflective of the first: the tmux server starts as a child of the shell initiating the
first session, and so inherits its environment; subsequent
tmux sessions merely connect to that pre-existing tmux server process, which then handles
spawning the window proceses that I incorrectly expected to reflect the environment of the
originating shell.

(Interestingly, it appears as if the tmux server actually runs inside the same process as
the first session, or visa versa&mdash;`/usr/bin/newproc.d`, a `dtrace` script that
monitors process creation, doesn't reveal a separate `tmux` server invocation forking away
from the `tmux new-session` call w/o an existing tmux server.)

To its minor credit, `tmux` offers a configuration option `update-environment`, which is a
list of environment variables to take from a client calling `tmux new-session` or `tmux
attach` and apply to the session environment, which is created on the server and would
otherwise not reflect the client's environment.

(To solve my problem, I added `set-option -ga update-environment ' TMUX_PROJECT'` to my .tmux.conf.)

## Unsolicited Opinion

So, this is nice, and so are the features that the client-server architecture provide, but
I think the default behavior for creating a new session, which, to the user looks and
feels like starting a child process, should be to overlay the entire client environment on
the server's (if the server's need come into play at all); the `update-environment` list
should then be used only in the case of attaching to an existing session.

But who knows&mdash;there are surely decent reasons it exists the way it does, if even just
because it was easier this way, and open source projects are rarely the most important thing in a programmer's life.

If you're a tmux dev, deep bow for all the amazing work!


# Kernel Curiosity: In Which Tree Does `elm make` Hide Its Nuts?
_5/3/2020_

The problems started when my `elm` bundle didn't seem to be picking up the changes I'd introduced into one of my project's dependencies (which I'd cloned locally, edited, and then symlinked into `~/.elm/packages/...` to replace the official distribution from the elm repository[1]). You probably know `elm make` caches some intermediate build artifacts in `<elm-project>/elm-stuff/`, but if you look closley, you'll see individual file entries only for your project's own source files, and a few strays.

It turns out `elm make` caches project deps all bundled up in the cryptically named `<elm-project>/elm-stuff/*.dat`. I had to guess this was the case when `/usr/bin/filebyproc.d` didn't show `elm make` access any files in `~/.elm/packages`&mdash;or anywhere outside of `<elm-project>/` for that matter&mdash;, since `o.dat`, in my case, was the only file large enough (several hundred KB as opposed to just a few for most other files) to be a bundle. `cat`ing it confirmed, spitting out just enough readable text to recognize some package names.

But `/usr/bin/filebyproc.d`! What a gem, along with `dtrace`[2] and all its helpers in `/usr/bin/*.d`. If you, an OS X user, are ever stumped as to where a process's configuration files live, or need to diagnose some sluggish disk or network activity, or you have any other syscall-related inquiry, take a longer look at `dtrace`. The `/usr/bin/*.d` collection is mostly comprised of `dtrace` one-liners for satisyfing common kernel curiosities&mdash;or reminding you that Adobe still has a daemon running years after you last opened your perfectly legal copy of Creative Suite...

1) I wrote myself a script to make hacking on elm packages in an existing project a bit easier, which includes removing the official dep source to nearby safety, and creating a symlink in its place to your cloned source; having checked out package repo from github, running [`elm.install-from-dir`](https://github.com/cameron/dotfiles/blob/master/bin/elm.install-from-dir) from the repo root will ensure that `elm make` will build against the cloned source.

2) Some `dtrace` resources to get you started:
- http://www.brendangregg.com/dtrace.html
- http://dtrace.org/blogs/brendan/2011/10/10/top-10-dtrace-scripts-for-mac-os-x/
- https://8thlight.com/blog/colin-jones/2015/11/06/dtrace-even-better-than-strace-for-osx.html


# Google First, Google Twice

Before spending a late night (ahem; two) trying to minimize a thirdparty sdk bundle size by parsing and manipulating the ast (definitely don't try to do it with bash!) to strip out unneeded code, make sure to check their build tools for options to do so :)

On the other hand, esprima is a wonderful library; I was able to write a script that took the AWS JavaScript SDK and remove unwanted modules, reducing file size by about 60%.

# Durable Nomenclature for Shell Helper Scripts
_4/28/2020_

(Shell helpers. Shellpers! Not sorry.)

Do you also sometimes write short wrapper scripts for commonly used shell commands? Like, I was tired of saying `doctl compute d create --image debian-10-x64 --size s-1vcpu-1gb --ssh-keys 123 --region sfo2`, so I wrote a wrapper (which accepts a name and a ram argument), and it went in `dotfiles/bin`, next to a small graveyard of similar scripts with terse, pithy names that don't always perfectly refresh my memory as to their intent after months of disuse (which is probably a good sign I can delete them, but nevermind).

In the course of cleaning out my dotfiles recently, I adopted a pattern for standarized shellper nomenclature: `<wrapped-command>.<slug>`. So, my `doctl` wrapper to create a droplet became `doctl.mk-droplet`. This makes rediscovering your helpers easy if you stray for too long to keep them all at your fingertips. Assuming you have some decent autocomplete configured in your shell, you'll get a listing of all relevant wrapers just by typing the beginning of the command you can't be bothered to complete.

# DNS as Load Balancer
_4/23/2020_
- multiple DNS A/AAAA records for the same value can act as a basic load balancer
- combine with floating IPs, an on-node process manager (systemd or docker swarm), and something to create new machines if one goes down hard, and you've got a rudimentary high availability system


# Custom Autocomplete for Fish Shell
_4/22/2020_

- `complete mycmd -n "condition_fn" -a "things to complete"` is (almost) all you need to get started
- `commandline -poc` is vital inside of `condition_fn`s for inspecting the current commandline to determine where you're at (and then returning 0/1 to indicate whether or not to use the -a completions for the current commandline)
- trying to generate completions for the entire doctl subcommand tree in fish from help output isn't impossible, but i will probably give it another try in python so i can use a dictionary to keep track of the subcommand tree
- there's a nice guide at https://fishshell.com/docs/current/index.html#writing-your-own-completions


# DNS records on the command line
_4/20/2020_
- `dig` comes in handy when debugging a certbot failure to registr/renew SSL certs via DNS challenge
  - `dig <domain> +short` will show the basic A/AAAA record IPs
  - `dig TXT <domain>` will return only TXT records
    - e.g., dig didn't return the records cloudflare claimed to have put on the domain. The next commands clarified why (dig and certbot were consulting old nameservers due to propagation delay from a recent nameserver change at the registrar).
  - `dig <domain> NS` will return the nameservers
  - the bottom of the command output has ';; SERVER ...', which is the server queried
  - specify a nameserver to query with `git @nameserver <domain>`


# systemd + git hooks = simple service deployment
_4/?/2020_
- http://github.com/cameron/push-to-systemd, when installed on a git server, will automatically install systemd service files found in the `push-to-systemd` folder of pushed repos. this makes for fast, easy service deploys, including, e.g., a docker build step by using the ExecStartPre directive in the service file.
- as of writing and using ansible, it's clear that the same is possible, and perhaps, preferrable, with ansible, as it doesn't require any additional software to live or run on the host. perhas the one feature that push-to-systemd has that ansible doesnt is that it pipes build output back to the user--which maybe ansible does with -vvv...
