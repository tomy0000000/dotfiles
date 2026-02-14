Install = spoon.SpoonInstall

-- Register the TaskHammer spoon repository
Install.repos["TaskHammer"] = {
    desc = "TaskHammer.spoon repository",
    url = "https://github.com/joemiller/taskhammer"
}

Install:andUse("TaskHammer",
    {
        repo = "TaskHammer",
        start = true,
        config = {
            tasks = {
                {
                    name = "Reload Icons",
                    cmd = "~/.dotfiles/pkg/macos-hammerspoon/.hammerspoon/scripts/macos-icons.sh",
                    env = {
                        PATH = "/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
                    }
                },
                {
                    name = "Archive Files",
                    cmd = "~/.dotfiles/pkg/macos-hammerspoon/.hammerspoon/scripts/macos-archive-file.sh",
                    env = {
                        PATH = "/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
                    }
                },
            }
        }
    }
)
