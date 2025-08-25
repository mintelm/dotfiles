## My Linux Dotfiles
TBD

### Installation
To install:
```bash
# OPTIONS: -f --force
./install.sh [-f]
```

### Fonts
To build:
```bash
git clone https://github.com/subframe7536/maple-font --depth 1 -b variable
python -m venv ./venv
source .venv/bin/activate
pip install -r requirements.txt
python build.py --no-liga --no-hinted
```
