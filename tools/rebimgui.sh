pushd Hypersomnia/src/3rdparty/imgui
git remote add upstream https://github.com/ocornut/imgui.git
git fetch upstream
git checkout master
git rebase upstream/master
