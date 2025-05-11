# Unraid hp-flash plugin

This is the repository for the hp-flash plugin.

Support: https://github.com/zt-luo/unraid-hp-flash/

## Usage

```shell
Usage: hp-flash [-q -y -h -?] [-p admin_password] [-i] filename
            -q  (Quiet Mode)    - Minimize text output
            -y  (Yes Mode)      - Answer Yes to everything (non-interactive)
            -h, -?              - Show this help message
            -p admin_password   - Input BIOS Admin Password
            -cspwdfile pwdfile  - Input Current BIOS Setup Password File
            -i filename|delete  - Flash (or delete) a custom startup logo image
            filename            - ROM binary or image file to flash

To suppress confirmation prompts (for non-interactive deployments), use the -y switch.
```

```shell
Usage: hp-repsetup [-g -s -q -a -h -?] [-p admin_password] [filename]
            -g  (Get Mode)      - Get BIOS settings
            -s  (Set Mode)      - Set BIOS Settings
            -q  (Quiet Mode)    - Minimize text output (default: Verbose Mode)
            -a  (ASCII Mode)    - Create file in ASCII format (default: Unicode UCS-2)*
                                  *Note: ASCII file cannot be imported with other tools
            -h, -?              - Show this help message
            -p admin_password   - Input Current BIOS Setup Password
            -n admin_password   - Input New BIOS Setup Password
            -n /                - Clears the BIOS Setup Password if the current
                                  password is supplied with -p or -cspwdfile
                                  option
            -cspwdfile pwdfile  - Input Current BIOS Setup Password File
            -nspwdfile pwdfile  - Input New BIOS Setup Password File
            filename            - Optional Name Of File To Save Settings To
                                  Or Restore Settings From (Default is HPSETUP.TXT)
```
