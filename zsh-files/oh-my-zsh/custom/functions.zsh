function cognita.cloud_rake {
    pushd
    cd /home/maser/dev/cognita/cloud
    bundle exec rake $1
    popd
}

function cognita.ssh {
    cognita.cloud_rake ssh\[$1\]
}
