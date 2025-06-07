## Usage

```bash
# Reload systemd and start service
systemctl --user daemon-reload
systemctl --user enable notes-sync.service
systemctl --user start notes-sync.service
```

View the status

```bash
# Check status
systemctl --user status notes-sync.service

# View logs
journalctl --user -u notes-sync.service -f
```
