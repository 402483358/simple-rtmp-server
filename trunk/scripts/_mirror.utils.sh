#!/bin/bash

#############################################
# help for the first checkout.
#############################################
function first_checkout()
{
    mirror_name=$1
    git_url=$2
    project_dir=$3
    sync_script=$4
    
    failed_msg "当前分支不是${mirror_name}镜像"; 
    
    cat <<END
创建
END
}

#############################################
# branch master
#############################################
function sync_master()
{
    for ((;;)); do
        git checkout srs.master && git pull 
        ret=$?; if [[ 0 -ne $ret ]]; then 
            failed_msg "";
            continue
        else
            ok_msg ""
        fi
        break
    done

    git checkout master && git merge srs.master
    ret=$?; if [[ 0 -ne $ret ]]; then failed_msg "失败, ret=$ret"; exit $ret; fi
    ok_msg "成功"
}

#############################################
# branch 1.0release
#############################################
function sync_1_0_release()
{
    for ((;;)); do
        git checkout srs.1.0release && git pull 
        ret=$?; if [[ 0 -ne $ret ]]; then 
            failed_msg "(1.0release)";
            continue
        else
            ok_msg "(1.0release)"
        fi
        break
    done

    git checkout 1.0release && git merge srs.1.0release
    ret=$?; if [[ 0 -ne $ret ]]; then failed_msg "(1.0release)失败, ret=$ret"; exit $ret; fi
    ok_msg "(1.0release)成功"
}

#############################################
# push
#############################################
function sync_push()
{
    mirror_name=$1
    
    for ((;;)); do 
        git push
        ret=$?; if [[ 0 -ne $ret ]]; then 
            failed_msg "重试";
            continue
        else
            ok_msg "成功"
        fi
        break
    done
    
    git checkout master
    ok_msg "成功"
}

