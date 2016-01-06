function cognita.cloud_rake {
    pushd
    cd ~/cognita/cloud
    bundle exec rake $1
    popd
}

function cognita.ssh {
    cognita.cloud_rake ssh\[$1\]
}

function rserver {
  ruby -run -e httpd . -p 5000
}

function s()
{
  ~/cognita/cloud/bin/rake -f ~/cognita/cloud/Rakefile ssh\[$1\]
}

function freemac()
{
  FREE_BLOCKS=$(vm_stat | grep free | awk '{ print $3 }' | sed 's/\.//')
  INACTIVE_BLOCKS=$(vm_stat | grep inactive | awk '{ print $3 }' | sed 's/\.//')
  SPECULATIVE_BLOCKS=$(vm_stat | grep speculative | awk '{ print $3 }' | sed 's/\.//')

  FREE=$((($FREE_BLOCKS+SPECULATIVE_BLOCKS)*4096/1048576))
  INACTIVE=$(($INACTIVE_BLOCKS*4096/1048576))
  TOTAL=$((($FREE+$INACTIVE)))
  echo Free:       $FREE MB
  echo Inactive:   $INACTIVE MB
  echo Total free: $TOTAL MB
}
