# macbook81-audio-profile

Speaker names and the shipped equalizer for the MacBook (Retina, 12-inch,
Early 2015), model `MacBook8,1`, on Omarchy.

This is not the driver. The driver is `macbook81-cs4208`. These files are
userspace, and they install without it. They do nothing useful until that
driver has created the 4-channel speaker device.

Two files:

- `51-mb81-rawpcm-speaker.conf` is WirePlumber. It puts the PCH card in
  raw-PCM mode, hides the digital device that shares the speaker
  converter, and names the nodes. The names are Headphones, Internal
  Microphone, and Speaker (Raw). Without this file the headphone output
  and the microphone both show as `CS4208 Analog`.
- `51-macbook81-speaker.conf` is the PipeWire equalizer. It creates the
  sink `MacBook Speaker (EQ)` and feeds `MacBook_Speaker_Raw`. The
  coefficients are the macOS layout100 speaker EQ shipped in
  [thomas-shirley/macbook8.1-speaker-driver](https://github.com/thomas-shirley/macbook8.1-speaker-driver)
  (`51-macbook81-speaker.conf`). That file calls them a published
  layout100 description. They were not measured on this machine, and
  they were not A/B'd against the raw speakers. The speakers sound
  good with them in the path. That is the claim, and no more.

## Install

```bash
bash apply.sh
systemctl --user restart wireplumber
```

Run it as the desktop user, not root. The files land in that user's
`~/.config`. The script does not restart WirePlumber, because that
restart drops whatever is playing.

## After restart

The menu shows Headphones, Internal Microphone, and Speaker (Raw).
`MacBook Speaker (EQ)` is the sink to play through.

## Revert

```bash
bash revert.sh
systemctl --user restart wireplumber
```

## For agents

Read `AGENTS.md` before changing this tree.

## License

MIT. See `LICENSE`. The equalizer coefficients are not original to this
repository.
