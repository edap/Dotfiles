function rserver {
  ruby -run -e httpd . -p 8080
}

function rlan {
  local ip_address
  ip_address=$(ip -4 addr show scope global | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -1)
  if [ -z "$ip_address" ]; then
    echo "Error: Could not determine your local IP address."
    return 1
  fi
  echo "Starting Ruby web server on http://$ip_address:8080"
  ruby -run -e httpd . -p 8080 -b "$ip_address"
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
