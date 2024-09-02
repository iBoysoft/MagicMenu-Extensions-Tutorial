# MagicMenu-Extensions-Tutorial
This repository contains some simple demos of MagicMenu extensions. It can help you better learn [MagicMenu Extensions Developer Reference](https://iboysoft.com/extensions/diy-extensions.html "iBoysoft MagicMenu Extensions Developer Reference") and easily create your extensions.    

## How The Extension Works
```
                                                 ┌────────────────────────┐
  ┌───────────┐          ┌─────────────┐         │ ┌───────────────────┐  │
  │           │          │             │     ┌───┼▶│  Your Extension   │  │
  │           │          │             │     │   │ └───────────────────┘  │
  │           │          │             │     │   │            │           │
  │           │          │             │     │   │            │           │
  │Finder Menu│          │ Dispatching │   params│         launch         │
  │Action from│─request─▶│ requests in │─────┘   │            │           │
  │   User    │          │  MagicMenu  │         │            ▼           │
  │           │          │             │         │  ┌──────────────────┐  │
  │           │          │             │         │  │     Actions      │  │
  │           │          │             │         │  └─┬───────┬────────┤  │
  │           │          │             │         │    │ Shell │  App   │  │
  └───────────┘          └─────────────┘         │    └───────┴────────┘  │
                                                 └────────────────────────┘
```

## Repository Layout
The main folders:

- `App Action Example` - App-based extension demo (Based on calling app functions).
- `Bash Action Example` - Shell-based extension demo (Based on calling script functions).  
- `Template` - Extension templates.  

## Create From Scratch
1. Go to Template folder and **right click** the **Template.magicmenux** -> **Show Package Contents** to view the internal structure of the template extension.
2. Prepare and replace icon.png (skip if you don't want to change the icon).
3. Copy the dependent **app** or **shell** into the extension folder.
4. Edit basic data in **manifest.json** using any editor (Visual Studio Code is recommended).
5. Add your own action configuration in the `actions` field (View the [developer documentation](https://iboysoft.com/extensions/diy-extensions.html) or dive into the examples).
6. Install your extension and try calling the extension action from the system right-click menu.
7. Debug it if needed until all functions work properly.
8. **Zip** the **YOUR-EXTENSION.magicmenux** folder and change the extension from `.zip` to `.magicmenuxz`.
9. Your zipped extension will run on any Mac with MagicMenu installed.

## Tips
If you want to display a dialog when using the shell action, you could use `osascript` like: 
```
osascript -e 'tell app "System Events" to display dialog "THIS IS A DIALOG!" buttons {"OK"} default button "OK"'
```

## Contributing
When your extension is complete, you could submit it to the [📦 extension repository](https://github.com/iBoysoft/MagicMenu-Extensions "iBoysoft MagicMenu Extension Repository"). Once the extension has been accepted, it can be published to the [official extension store](https://iboysoft.com/extensions/?ref=github "iBoysoft MagicMenu Extension Store").
