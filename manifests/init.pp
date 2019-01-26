# file: manifests/init.pp
stage { [server, bd, wp]: }
Stage[server] -> Stage[bd] -> Stage[wp]

class { 'apache': stage => server }
class { 'mysql': stage => bd }
class { 'wordpress': stage => wp }
