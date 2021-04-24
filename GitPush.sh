#!/bin/bash

#
# 脚本用途：
#     用于一键提交代码到远程仓库中
#

# 提交信息
message=""
# 是否是自动提交
autoPush=0

# 显示帮助文档
function showHelper() {
    echo ""
    echo "使用方法： [-a][-m][-h][--help]"
    echo "        -a: 自动提交"
    echo "        -m: 提交信息"
    echo "        -h or --help: 显示帮助信息"
    echo ""
}

# 主脚本
function main() {
    gitDir="./.git"
    if [ -d $gitDir ];then
        gitStatu=`git status`
        noChangeMsg="nothing to commit, working tree clean"
        hasCommitMsg="Your branch is ahead of 'origin/master' by"
        # echo $gitStatu
        if [[ $gitStatu =~ $noChangeMsg ]] && [[ ! $gitStatu =~ $hasCommitMsg ]];then
            echo -e "\e[1;33m警告：没有需要提交的代码\e[0m"
            return 0
        else
            if [ $autoPush -eq 1 ];then
                git add -A
                if [[ -z $message ]];then
                    read -p "请输入提交信息：" message
                fi
                git commit -m "$message"
                pullInfo=`git pull --rebase`
                echo $pullInfo
                pullSuccess="Current branch master is up to date."
                pullSuccess1="Successfully rebased and updated"
                if [[ $pullInfo =~ $pullSuccess ]] || [[ $pullInfo =~ $pullSuccess1 ]];then
                    for remote in `git remote | awk '{print $0}'`
                    do
                        index=0
                        while [ $index -lt 3 ]
                        do
                            echo "正在执行 git push $remote 第 $index 次"
                            git push $remote
                            if [ $? -eq 0 ];then
                                index=4
                            else
                                let index++
                                if [ $index -lt 3 ];then
                                    echo -e "\e[1;31m错误：上传代码至$remote仓库失败\e[0m"
                                    return 1
                                fi
                            fi
                        done
                    done
                else
                    echo -e "\e[1;31m错误：更新代码失败\e[0m"
                    return 1
                fi
            else
                if [[ ! $gitStatu =~ $noChangeMsg ]] && [[ ! $gitStatu =~ $hasCommitMsg ]];then
                    git status
                    read -p "是否提交修改代码到仓库？（Y/N)" commint
                    if [[ $commint == Y ]] || [[ $commint == y ]];then
                        git add -A
                        if [[ -z $message ]];then
                            read -p "请输入提交信息：" message
                        fi
                        git commit -m "$message"
                    else
                        return 1
                    fi
                fi
                read -p "是否上传代码到远程服务器？(Y/N)" push
                if [[ $push == "Y" ]] || [[$push == "y" ]];then
                    pullInfo=`git pull --rebase`
                    echo $pullInfo
                    pullSuccess="Current branch master is up to date."
                    pullSuccess1="Successfully rebased and updated"
                    if [[ $pullInfo =~ $pullSuccess ]] || [[ $pullInfo =~ $pullSuccess1 ]];then
                        for remote in `git remote | awk '{print $0}'`
                        do
                            index=0
                            while [ $index -lt 3 ]
                            do
                                echo "正在执行 git push $remote 第 $index 次"
                                git push $remote
                                if [ $? -eq 0 ];then
                                    index=4
                                else
                                    let index++
                                    if [ $index -lt 3 ];then
                                        echo -e "\e[1;31m错误：上传代码至$remote仓库失败\e[0m"
                                        return 1
                                    fi
                                fi
                            done
                        done
                    else
                        echo -e "\e[1;31m错误：更新代码失败\e[0m"
                        return 1
                    fi
                else
                    return 1
                fi
            fi
        fi
    else
        echo -e "\e[1;31m错误：当前目录不是一个仓库\e[0m"
        return 5
    fi
}

# 开始执行脚本，并将脚本参数传递给 main 函数
# 是否需要退出
needExit=0
# 脚本执行状态
statu=0
# 上一个参数
lastArg=""
# 遍历脚本参数
while [ $# != 0 ];do
    # 解析脚本参数
    case $1 in
        # 适配所有以 --开头的字符串
        --help)
            showHelper
            needExit=1
            ;;

        -a)
            autoPush=1
            lastArg="-a"
            ;;

        # 适配所有以 - 开头的字符串
        -*)
            if [[ $1 = "-h" ]];then
                showHelper
                needExit=1
            fi
            lastArg=$1
            ;;

        # 适配所有不以 - 或 -- 开头的字符串
        *)
            case $lastArg in
                -m)
                    message=$1
                    ;;
                *)
                    echo -e "\e[1;31m错误：未知参数$1"
                    statu=1
            esac
            lastArg=""
            ;;
    esac
    shift
done

if [ $needExit -eq 0 ];then
    echo ""
    echo "autoPush: $autoPush"
    echo "message: $message"
    echo ""
fi

if [ $statu -eq 0 ] && [ $needExit -eq 0 ];then
    main
    statu=$?
fi

if [ $needExit -eq 0 ];then
    echo ""
    if [ $statu -eq 0 ];then
        echo -e "\e[1;32m========================================= 执行成功 =========================================\e[0m"
    else
        echo -e "\e[1;31m========================================= 执行失败 =========================================\e[0m"
    fi
fi