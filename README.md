# vcache-manager
vcache fleet management


./bin/vcache-mgr-start [-d|--debug]
./bin/vcache-mgr-stop [-r|--real-clean] [-c|--clean]

./bin/vcache-deploy [-?|--help] [-d|--debug] [-D|--dry-run] [f|--force]
                    [-u|--ssh-user <ssh-user>] [-p|--ssh-password <ssh-password>]
                    [-k|--ssh-key <ssh-key>] [-h|--ssh-host <ssh-host>]
                    [-m|--mgr-addr <mgr-addr>] [-g|--gen-keys] [-t|--target-dir]
                    [-r|--roster-file <roster-file>] [-C|--command-arg <cmd-arg>]*
                    (-i|--installer <installer> | -c|--command <cmd>*)
                    
./bin/vcache-deploy -i ../vcache/release/vcache-0.6.3.run -r vcache.roster -m 10.14.25.253 -g -C '-c' -C '4G' -C '-b' -C '-r'
./bin/vcache-deploy -r vcache.roster -c './vcache-0.6.3/bin/vcache-uninstall.sh'

