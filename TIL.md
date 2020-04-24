# Today I Learned
_Technical snippets and sizzle_

# DNS as Load Balancer
_4/23/2020_
- multiple DNS A/AAAA records for the same value can act as a basic load balancer
- combine with floating IPs, an on-node process manager (systemd or docker swarm), and something to create new machines if one goes down hard, and you've got a pretty solid high availability system


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