# Linux_Productive-Workspace-Set-Up

## Main Features

### All-In-One Setup Script

If you're using `zsh`, Run/execute the below file:

- Main reference: [Get Started Script](./linux/start/all-in-one_zsh.sh)

Includes:

1. My custom/public alias: `git`, `kubectl`, `helm`, `terraform`, ...

- Example `kubectl`: https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/alias/kubernetes/kubectl-aliases/.kubectl_aliases
- All alias at: `/linux/alias/.<TOOL-NAME>_alias`

2. ZSH Plugins + Themes + MOTD (Require any [Nerd Fonts](https://www.nerdfonts.com/) )

_<You can custom the ASCII Image: `MOTD_IMAGE_URL`>_

<img width="1759" height="531" alt="image" src="https://github.com/user-attachments/assets/ad87dd5e-0c77-4263-a299-4034f0da2c80" />

3. Shell configuration

Convenient for later uses + labs

<img width="996" height="934" alt="image" src="https://github.com/user-attachments/assets/1db55a69-970c-455b-9f48-d2fc4a7ddd4d" />

4. Git Hook (Pre-push)

_<You can custom this script: `GITHOOK_PREPUSH_SCRIPT`>_

Scanning for repo's secrets. **"Generic Password" -> Skipped**
Require:

- ggshield
- trufflehog
- jq
- jbtl

<img width="909" height="1216" alt="image" src="https://github.com/user-attachments/assets/290460cf-e299-4807-8f21-3b8106392af8" />

5. Command Auto-completion: `helm`, `kubectl`, ...

> NOTE: Customize the whole script to any of your likings

### Parameters

Modify variables script suits your need

| Variable               | Description                                                                                                   | Example                                                                                                                                                            |
| ---------------------- | ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| MOTD_IMAGE_URL         | ASCII image when opening new shell terminal (Message of the day)                                              | https://raw.githubusercontent.com/khangtictoc/DevOps-Tools-Installation-Scripts/refs/heads/main/linux/installation/terminal/ui/startup/neofetch/cat_in_the_box.txt |
| DF_GITPROFILE_NAME     | (Optional) Name of your profile, prints out in execution's output                                             | myproductiveprofile                                                                                                                                                |
| DF_GITPROFILE_URL      | URL of your profile's config                                                                                  | https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/utility/configuration/git/profile/khangtictoc.sh                   |
| GITHOOK_PREPUSH_SCRIPT | URL of your Github pre-push Hook's script NOTE: If set, `core.hookPath` will be configured as global settings | https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/utility/configuration/git/hook/pre-push                            |

## Others

Snippet codes and other config: SSH Config Template , Github rules , ... for personal uses. If you want to adapt it , change it your way or use with cares please =)))

Includes:

- SSH Config templates -> More productive works with SSH command & alias: [Shared](./linux/cheatsheet/network/ssh/config)
- Github Pre-push hooks (Installed above): [Shared](./linux/utility/configuration/git/hook/pre-push)
- Github Profile (Example): [Shared](./linux/utility/configuration/git/profile/khangtictoc.sh)
- Command cheatsheets: [Shared](./linux/cheatsheet/)
- Snippet code: [Shared](./linux/utility/snippet-code/)
- Public bash library: [Shared](./linux/utility/library/bash/)
- ...
